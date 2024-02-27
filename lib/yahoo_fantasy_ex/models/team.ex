defmodule YahooFantasyEx.Models.Team do
  @moduledoc false

  alias YahooFantasyEx.Models.Player.Stat

  use YahooFantasyEx.Model,
    fields: [
      clinched_playoffs: :boolean,
      faab_balance: :integer,
      has_draft_grade: :boolean,
      league_scoring_type: :atom,
      managers: {:array, &Team.manager/1},
      name: :string,
      number_of_moves: :integer,
      number_of_trades: :integer,
      team_id: :integer,
      team_key: :string,
      team_live_projected_points: &Team.points/1,
      team_logos: &Team.logo/1,
      team_projected_points: &Team.points/1,
      team_points: &Team.points/1,
      team_remaining_games: &Team.remaining_games/1,
      team_standings: &Team.standings/1,
      team_stats: &Team.stats/1,
      url: :string,
      waiver_priority: :integer
    ]

  def manager(%{manager: manager}) do
    %{
      email: manager.email,
      felo_score: cast_integer(manager.felo_score),
      felo_tier: cast_atom!(manager.felo_tier),
      guid: manager.guid,
      image_url: manager.image_url,
      manager_id: cast_integer(manager.manager_id),
      nickname: manager.nickname
    }
  end

  def points(%{total: total_points}), do: cast_float(total_points)
  def points(nil), do: nil

  def remaining_games(%{remaining_games: remaining_games}), do: cast_integer(remaining_games)
  def remaining_games(nil), do: nil

  def standings(nil), do: nil

  def standings(team_standings) do
    %{
      wins: get_in(team_standings, ["outcome_totals", "wins"]) |> cast_integer(),
      losses: get_in(team_standings, ["outcome_totals", "losses"]) |> cast_integer(),
      ties: get_in(team_standings, ["outcome_totals", "ties"]) |> cast_integer(),
      percentage: get_in(team_standings, ["outcome_totals", "percentage"]) |> cast_float(),
      playoff_seed: Map.get(team_standings, "playoff_seed") |> cast_integer(),
      points_for: Map.get(team_standings, "points_for") |> cast_float(),
      points_against: Map.get(team_standings, "points_against") |> cast_float(),
      rank: Map.get(team_standings, "rank") |> cast_integer()
    }
  end

  def stats(%{stats: stats}), do: Enum.map(stats, &Stat.new/1)
  def stats(nil), do: nil

  def logo([%{team_logo: %{url: url}}]), do: url
  def logo(_), do: nil
end
