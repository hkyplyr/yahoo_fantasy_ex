defmodule YahooFantasyEx.Models.League.Settings.RosterPosition do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :count,
    :is_starting_position,
    :position,
    :position_type
  ]

  @type t :: %__MODULE__{
          count: integer(),
          is_starting_position: boolean(),
          position: atom(),
          position_type: atom()
        }

  @spec new(map()) :: t()
  def new(%{roster_position: data}) do
    data
    |> transform(
      count: &cast_integer/1,
      is_starting_position: &cast_boolean/1,
      position: &translate_position/1,
      position_type: &translate_position_type(&1)
    )
  end
end
