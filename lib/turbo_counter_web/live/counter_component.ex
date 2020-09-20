defmodule TurboCounterWeb.CounterComponent do
  use TurboCounterWeb, :live_component
  # use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <tr>
        <td><%= @counter.name %> </td><td> <%= @counter.count %></td>
        <td>
        <button phx-click="increase" phx-value-counter="<%= @counter.name %>">
        +
        </button>
        | <button phx-click="decrease" phx-value-counter="<%= @counter.name %>">
        -
        </button>
        | <button phx-click="reset" phx-value-counter="<%= @counter.name %>">
        Clear
        </button>
        </td>
    </tr>
    """
  end
end
