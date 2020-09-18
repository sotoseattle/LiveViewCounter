defmodule TurboCounter.Counters.Counter do
  import Ecto.Changeset

  defstruct [:name, count: 0]
  @types %{name: :string, count: :integer}

  def new, do: %__MODULE__{}

  def new_change(params, counters) do
    {new(), @types}
    |> cast(params, Map.keys(@types))
    |> validate_required(:name)
    |> validate_exclusion(
        :name,
        Map.keys(counters),
        message: "can't be repeated")
    |> validate_length(:name, min: 3, max: 20)
  end
end
