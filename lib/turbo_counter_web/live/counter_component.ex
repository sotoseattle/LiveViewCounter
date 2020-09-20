defmodule TurboCounterWeb.CounterComponent do
  use TurboCounterWeb, :live_component
  alias TurboCounter.Counters

  def mount(socket) do
    {:ok, assign(socket, counter: Counters.new_counter())}
  end

  def update(assigns, socket) do
    {
      :ok,
      assign(socket, counter: Counters.update_name(socket.assigns.counter, assigns.counter))
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
    {:noreply, increase_counter(socket)}
  end

  def handle_event("decrease", _, socket) do
    {:noreply, decrease_counter(socket)}
  end

  def handle_event("reset", _, socket) do
    {:noreply, reset_counter(socket)}
  end
end
