defmodule TurboCounter.Counters do
  alias TurboCounter.Counters.Counter

  def new, do: []

  def add_counter(counters, name) do
    [name | counters]
  end

  def validate_new_counter(counters, new_counter_params) do
    Counter.new_change(new_counter_params, counters)
  end

  def update_name(counter, name) do
    Map.put(counter, :name, name)
  end

  def new_counter(), do: Counter.new()
  def clear(counter), do: Counter.clear(counter)
  def inc(counter), do: Counter.inc(counter)
  def dec(counter), do: Counter.dec(counter)
end
