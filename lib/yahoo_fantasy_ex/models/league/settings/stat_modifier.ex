defmodule YahooFantasyEx.Models.League.Settings.StatModifier do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [:stat_id, :value]

  @type t :: %__MODULE__{
          stat_id: integer(),
          value: float()
        }

  @spec new(map()) :: t()
  def new(%{"stat" => data}) do
    data
    |> super()
    |> transform(
      stat_id: &cast_integer/1,
      value: &cast_float/1
    )
  end
end
