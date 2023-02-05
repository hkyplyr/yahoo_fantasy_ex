defmodule YahooFantasyEx.Models.Player.Stat do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [:stat_id, :value]

  @type t :: %__MODULE__{
          stat_id: integer() | nil,
          value: float() | nil
        }

  @spec new(map() | list(map())) :: t() | list(t()) | nil
  def new(%{"stats" => data}) when is_list(data) do
    Enum.map(data, &new/1)
  end

  def new(%{"stat" => data}) do
    data
    |> super()
    |> transform(
      stat_id: &cast_integer/1,
      value: &cast_float/1
    )
  end

  def new(_), do: []
end
