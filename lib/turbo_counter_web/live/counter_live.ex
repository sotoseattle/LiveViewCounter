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
      <%= live_component @socket, CounterComponent, counter: counter %>
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

  defp add_counter(socket, counter_params) do
    if socket.assigns.changeset.valid? do
      socket
      |> assign(counters: Counters.add_counter(socket.assigns.counters, counter_params))
      |> new_changeset()
    else
      socket
    end
  end

  defp increase_counter(socket, name) do
    assign(socket, counters: Counters.inc(socket.assigns.counters, name))
  end

  defp decrease_counter(socket, name) do
    assign(socket, counters: Counters.dec(socket.assigns.counters, name))
  end

  defp reset_counter(socket, name) do
    assign(socket, counters: Counters.clear(socket.assigns.counters, name))
  end

  # EVENT HANDLERS

  def handle_event("validate", %{"counter" => params}, socket) do
    {:noreply, validate(socket, params)}
  end

  def handle_event("save", %{"counter" => params}, socket) do
    {:noreply, add_counter(socket, params)}
  end

  def handle_event("increase", %{"counter" => name}, socket) do
    {:noreply, increase_counter(socket, name)}
  end

  def handle_event("decrease", %{"counter" => name}, socket) do
    {:noreply, decrease_counter(socket, name)}
  end

  def handle_event("reset", %{"counter" => name}, socket) do
    {:noreply, reset_counter(socket, name)}
  end
end
