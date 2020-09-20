defmodule TurboCounterWeb.CounterComponent do
  use TurboCounterWeb, :live_component
  alias TurboCounter.Counters

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    {
      :ok,
      assign(socket, counter: assigns.counter)
    }
  end

  def render(assigns) do
    ~L"""
    <tr>
        <td><%= @counter.name %> </td><td> <%= @counter.count %></td>
        <td>
        <button
        phx-click="increase"
        phx-target="<%= @myself %>"
        phx-value-counter="<%= @counter.name %>">
        +
        </button>
        | <button
        phx-click="decrease"
        phx-target="<%= @myself %>"
        phx-value-counter="<%= @counter.name %>">
        -
        </button>
        | <button
        phx-click="reset"
        phx-target="<%= @myself %>"
        phx-value-counter="<%= @counter.name %>">
        Clear
        </button>
        </td>
    </tr>
    """
  end


  defp increase_counter(socket) do
    assign(socket, counter: Counters.inc(socket.assigns.counter))
  end

  defp decrease_counter(socket) do
    assign(socket, counter: Counters.dec(socket.assigns.counter))
  end

  defp reset_counter(socket) do
    assign(socket, counter: Counters.clear(socket.assigns.counter))
  end

  def handle_event("increase", _, socket) do
    send self(), {:updated_counter, increase_counter(socket)}
    {:noreply, socket}
  end

  def handle_event("decrease", _, socket) do
    send self(), {:updated_counter, decrease_counter(socket)}
    {:noreply, socket}
  end

  def handle_event("reset", _, socket) do
    send self(), {:updated_counter, reset_counter(socket)}
    {:noreply, socket}
  end
end
