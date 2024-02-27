defmodule YahooFantasyEx.Models.Matchup.StatWinner do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :is_tied,
    :stat_id,
    :winner_team_key
  ]

  @type t :: %__MODULE__{
          is_tied: boolean(),
          stat_id: integer(),
          winner_team_key: String.t()
        }

  @spec new(map() | [map()]) :: t() | [t()]
  def new(stat_winners) when is_list(stat_winners) do
    Enum.map(stat_winners, &new/1)
  end

  def new(%{"stat_winner" => data}) do
    data
    |> transform(
      is_tied: &cast_boolean/1,
      stat_id: &cast_integer/1
    )
  end
end
