defmodule TurboCounterWeb.CounterLive do
  use TurboCounterWeb, :live_view

  alias TurboCounter.Counters
  alias TurboCounterWeb.CounterComponent

  def mount(_params, _session, socket) do
    {:ok, socket |> new() |> new_changeset()}
  end

  defp new(socket) do
    assign(socket, counters: Counters.new())
  end

  defp new_changeset(socket) do
    assign(
      socket,
      changeset: Counters.validate_new_counter(socket.assigns.counters, %{}))
  end

  def render(assigns) do
    ~L"""
    <h1>Counters</h1>
    <table>
    <%= for counter <- @counters do %>
      <%= live_component(
        @socket,
        CounterComponent,
        id: counter["name"],
        counter: counter["name"]
       ) %>
    <% end %>
    </table>

    <div>
      <%= f = form_for @changeset, "#",
        phx_change: "validate",
        phx_submit: "save" %>

        <%= label f, :name %>
        <%= text_input f, :name %>
        <%= error_tag f, :name %>

        <%= submit "Add counter",
            phx_disable_with: "Adding...",
            disabled: !@changeset.valid? %>
      </form>
    </div>
    """
  end

  # INTERFACE WITH CORE

  defp validate(socket, params) do
    changeset =
      socket.assigns.counters
      |> Counters.validate_new_counter(params)
      |> Map.put(:action, :validate)

      assign(socket, changeset: changeset)
  end

  defp add_counter(socket, counter_name) do
    if socket.assigns.changeset.valid? do
      socket
      |> assign(counters: Counters.add_counter(socket.assigns.counters, counter_name))
      |> new_changeset()
    else
      socket
    end
  end

  # EVENT HANDLERS

  def handle_event("validate", %{"counter" => params}, socket) do
    {:noreply, validate(socket, params)}
  end

  def handle_event("save", %{"counter" => name}, socket) do
    {:noreply, add_counter(socket, name)}
  end
end
