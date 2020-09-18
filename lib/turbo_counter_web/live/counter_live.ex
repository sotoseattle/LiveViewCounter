defmodule TurboCounterWeb.CounterLive do
  use TurboCounterWeb, :live_view

  alias TurboCounter.Counters

  def mount(_params, _session, socket) do
    {:ok, new(socket)}
  end

  defp new(socket) do
    params    = %{}
    counters  = Counters.new()
    changeset = Counters.validate_new_counter(counters, params)

    assign(socket, counters: counters, changeset: changeset)
  end

  def render(assigns) do
    ~L"""
    <h1>Counters</h1>
    <ul>
    <%= for {counter_name, v} <- @counters do %>
    <li>
    <%= counter_name %> : <%= v %>
    <button phx-click="advance_count" phx-value-counter="<%= counter_name %>">
    +
    </button>
    <button phx-click="reverse_count" phx-value-counter="<%= counter_name %>">
    -
    </button>
    <button phx-click="clear_count" phx-value-counter="<%= counter_name %>">
    Clear
    </button>
    </li>
    <% end %>
    </ul>

    <div>
      <%= f = form_for @changeset, "#",
        phx_change: "validate",
        phx_submit: "save" %>

        <%= label f, :name %>
        <%= text_input f, :name %>
        <%= error_tag f, :name %>

        <%= submit "Add counter", phx_disable_with: "Adding..." %>
      </form>
    </div>
    """
  end

  # EVENT HANDLERS

  def handle_event("validate", %{"counter" => params}, socket) do
    {:noreply, validate(socket, params)}
  end

  def handle_event("save", %{"counter" => params}, socket) do
    {:noreply, assign(socket, counters: add(socket, params))}
  end

  # def handle_event("add_counter", %{"counter" => params}, socket) do
  #   {:noreply, assign(socket, counters: add(socket, params))}
  # end

  def handle_event("advance_count", %{"counter" => name}, socket) do
    {:noreply, assign(socket, counters: inc(socket, name))}
  end

  def handle_event("reverse_count", %{"counter" => name}, socket) do
    {:noreply, assign(socket, counters: dec(socket, name))}
  end

  def handle_event("clear_count", %{"counter" => name}, socket) do
    {:noreply, assign(socket, counters: clear(socket, name))}
  end

  # INTERFACE WITH CORE

  defp validate(socket, params) do
    changeset =
      socket.assigns.counters
      |> Counters.validate_new_counter(params)
      |> Map.put(:action, :validate)

      assign(socket, changeset: changeset)
  end

  defp inc(socket, name) do
    Counters.tick(socket.assigns.counters, name)
  end

  defp dec(socket, name) do
    Counters.back(socket.assigns.counters, name)
  end

  defp add(socket, counter_params) do
    Counters.add_counter(socket.assigns.counters, counter_params)
  end

  defp clear(socket, name) do
    Counters.clear(socket.assigns.counters, name)
  end
end
