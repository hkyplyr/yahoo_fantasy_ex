defmodule YahooFantasyEx.Models.Team do
  @moduledoc false

  alias YahooFantasyEx.Models.Player.Stat

  use YahooFantasyEx.Model,
    fields: [
      clinched_playoffs: :boolean,
      faab_balance: :integer,
      has_draft_grade: :boolean,
      league_scoring_type: :atom,
      name: :string,
      number_of_moves: :integer,
      number_of_trades: :integer,
      team_id: :integer,
      team_key: :string,
      team_live_projected_points: &Team.points/1,
      team_logos: &Team.logo/1,
      team_projected_points: &Team.points/1,
      team_points: &Team.points/1,
      team_stats: &Team.stats/1,
      url: :string,
      waiver_priority: :integer,
      managers: {:many, YahooFantasyEx.Models.Team.Manager}
    ]

  def points(%{total: total_points}), do: cast_float(total_points)
  def points(nil), do: nil

  def stats(%{stats: stats}), do: Enum.map(stats, &Stat.new/1)
  def stats(nil), do: nil

  def logo([%{team_logo: %{url: url}}]), do: url
  def logo(_), do: nil
end
