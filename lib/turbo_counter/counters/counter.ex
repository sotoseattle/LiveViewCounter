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
        counters,
        message: "can't be repeated")
    |> validate_length(:name, min: 3, max: 20)
  end

  def clear(counter) do
    Map.put(counter, :count, 0)
  end

  def inc(counter) do
    Map.put(counter, :count, counter.count + 1)
  end

  def dec(counter) do
    Map.put(counter, :count, counter.count - 1)
  end
end
