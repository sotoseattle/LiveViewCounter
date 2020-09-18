defmodule TurboCounter.Counters do
  alias TurboCounter.Counters.Counter

  def new, do: %{}

  def add_counter(counters, params) do
    changeset = Counter.new_change(params, counters)
    if changeset.valid? do
      Map.put(counters, params["name"], params["count"])
    else
      #
    end
  end

  def add_counter(counters) do
    Map.put(counters, next_counter_name(counters), 0)
  end

  defp next_counter_name(counters) do
    counters
    |> Map.keys()
    |> Enum.map(&String.to_integer/1)
    |> Enum.max()
    |> Kernel.+(1)
    |> to_string()
  rescue
    _e -> "1"
  end

  def validate_new_counter(counters, new_counter_params) do
    Counter.new_change(new_counter_params, counters)
  end

  def clear(counters, name) do
    Map.put(counters, name, 0)
  end

  def delete_counter(counters, name) do
    Map.delete(counters, name)
  end

  def tick(counters, name) do
    Map.put(counters, name, counters[name] + 1)
  end

  def back(counters, name) do
    Map.put(counters, name, counters[name] - 1)
  end
end
