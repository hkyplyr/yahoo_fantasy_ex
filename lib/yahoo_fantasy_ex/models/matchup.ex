defmodule YahooFantasyEx.Models.Matchup do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :is_consolation,
    :is_playoffs,
    :is_tied,
    :stat_winners,
    :status,
    :teams,
    :week,
    :week_end,
    :week_start,
    :winner_team_key
  ]

  @type t :: %__MODULE__{
          is_consolation: boolean(),
          is_playoffs: boolean(),
          is_tied: boolean(),
          stat_winners: [StatWinner.t()],
          status: atom(),
          teams: [Team.t()],
          week: integer(),
          week_end: String.t(),
          week_start: String.t(),
          winner_team_key: String.t()
        }

  def new({_, %{"matchup" => matchup}}) do
    matchup
    |> super()
    |> transform(
      is_consolation: &cast_boolean/1,
      is_playoffs: &cast_boolean/1,
      is_tied: &cast_boolean/1,
      stat_winners: &StatWinner.new/1,
      status: &cast_atom!/1,
      week: &cast_integer/1
    )
    |> then(&%{&1 | teams: parse_teams(matchup)})
  end

  defp parse_teams(%{"0" => %{"teams" => teams}}) do
    teams
    |> Enum.reject(&(elem(&1, 0) == "count"))
    |> Enum.map(&Team.new/1)
  end
end
