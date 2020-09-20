defmodule TurboCounter.Counters.Counter do
  import Ecto.Changeset

  defstruct [:name, count: 0]
  @types %{name: :string, count: :integer}

  def new, do: %__MODULE__{}
  def new(params) do
    %__MODULE__{ name: params["name"], count: params["count"] || 0 }
  end

  def new_change(params, counters) do
    {new(), @types}
    |> cast(params, Map.keys(@types))
    |> validate_required(:name)
    |> validate_exclusion(
        :name,
        counter_names(counters),
        message: "can't be repeated")
    |> validate_length(:name, min: 3, max: 20)
  end

  defp counter_names(counters) do
    counters |> Enum.map(&(&1.name))
  end

  defp fetch_counter(name, counters) do
    counters |> Enum.find(&(&1.name == name))
  end

  defp substitute(counter, counters) do
    counters
    |> Enum.map(fn x ->
      if x.name == counter.name, do: counter, else: x
    end)
  end

  def clear(name, counters) do
    name |> fetch_counter(counters) |> Map.put(:count, 0) |> substitute(counters)
  end

  def inc(name, counters) do
    c = fetch_counter(name, counters)
    Map.put(c, :count, c.count + 1) |> substitute(counters)
  end

  def dec(name, counters) do
    c = fetch_counter(name, counters)
    Map.put(c, :count, c.count - 1) |> substitute(counters)
  end
end
