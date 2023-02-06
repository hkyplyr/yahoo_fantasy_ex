defmodule YahooFantasyEx.Models.Team do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :clinched_playoffs,
    :faab_balance,
    :has_draft_grade,
    :league_scoring_type,
    :managers,
    :name,
    :number_of_moves,
    :number_of_trades,
    :team_id,
    :team_key,
    :team_live_projected_points,
    :team_logos,
    :team_projected_points,
    :team_points,
    :team_remaining_games,
    :url,
    :waiver_priority
  ]

  @type t :: %__MODULE__{
          clinched_playoffs: boolean(),
          faab_balance: integer(),
          has_draft_grade: boolean(),
          league_scoring_type: atom(),
          managers: [Manager.t()],
          name: String.t(),
          number_of_moves: integer(),
          number_of_trades: integer(),
          team_id: integer(),
          team_key: String.t(),
          team_live_projected_points: float() | nil,
          team_logos: String.t(),
          team_projected_points: float() | nil,
          team_points: float() | nil,
          team_remaining_games: integer() | nil,
          url: String.t(),
          waiver_priority: integer()
        }

  @spec new(map() | tuple()) :: t()
  def new({_, %{"team" => data}}) do
    data
    |> flatten_attributes()
    |> super()
    |> transform(
      clinched_playoffs: &cast_boolean/1,
      faab_balance: &cast_integer/1,
      has_draft_grade: &cast_boolean/1,
      league_scoring_type: &cast_atom!/1,
      managers: &Manager.new/1,
      number_of_moves: &cast_integer/1,
      number_of_trades: &cast_integer/1,
      team_id: &cast_integer/1,
      team_live_projected_points: &parse_live_projected_points/1,
      team_logos: &extract_team_logo/1,
      team_projected_points: &parse_projected_points/1,
      team_points: &parse_points/1,
      team_remaining_games: &parse_remaining_games/1,
      waiver_priority: &cast_integer/1
    )
  end

  defp parse_live_projected_points(%{"total" => total_points}), do: cast_float(total_points)
  defp parse_live_projected_points(_), do: nil

  defp parse_projected_points(%{"total" => total_points}), do: cast_float(total_points)
  defp parse_projected_points(_), do: nil

  defp parse_points(%{"total" => total_points}), do: cast_float(total_points)
  defp parse_points(_), do: nil

  defp parse_remaining_games(%{"remaining_games" => remaining_games}),
    do: cast_integer(remaining_games)

  defp parse_remaining_games(_), do: nil

  defp extract_team_logo([%{"team_logo" => %{"url" => url}}]), do: url
  defp extract_team_logo(_), do: nil
end
