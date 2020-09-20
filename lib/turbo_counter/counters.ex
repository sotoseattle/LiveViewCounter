defmodule TurboCounter.Counters do
  alias TurboCounter.Counters.Counter

  def new, do: []

  def add_counter(counters, params) do
    [Counter.new(params) | counters]
  end

  def validate_new_counter(counters, new_counter_params) do
    Counter.new_change(new_counter_params, counters)
  end

  # def delete_counter(counters, name) do
  #   Map.delete(counters, name)
  # end

  def clear(counter), do: Counter.clear(counter)
  def inc(counter), do: Counter.inc(counter)
  def dec(counter), do: Counter.dec(counter)
end
