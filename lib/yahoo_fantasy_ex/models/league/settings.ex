defmodule YahooFantasyEx.Models.League.Settings do
  @moduledoc false

  alias YahooFantasyEx.Models.League.Settings
  alias YahooFantasyEx.Models.League.Settings.StatCategory

  use YahooFantasyEx.Model,
    fields: [
      can_trade_draft_picks: :boolean,
      cant_cut_list: :atom,
      draft_pick_time: :integer,
      draft_time: :integer,
      draft_together: :boolean,
      draft_type: :atom,
      has_multiweek_championship: :boolean,
      has_playoff_consolation_games: :boolean,
      is_auction_draft: :boolean,
      max_teams: :integer,
      max_weekly_adds: :integer,
      min_games_played: :integer,
      num_playoff_consolation_teams: :integer,
      num_playoff_teams: :integer,
      persistent_url: :string,
      player_pool: :atom,
      playoff_start_week: :integer,
      post_draft_players: :atom,
      roster_import_deadline: :date,
      roster_positions: {:many, YahooFantasyEx.Models.League.Settings.RosterPosition},
      scoring_type: :atom,
      sendbird_channel_url: :string,
      stat_categories: {:many, YahooFantasyEx.Models.League.Settings.StatCategory},
      stat_modifiers: &Settings.stat_modifiers/1,
      trade_end_date: :date,
      trade_ratify_type: :atom,
      trade_reject_time: :integer,
      uses_faab: :boolean,
      uses_lock_eliminated_teams: :boolean,
      uses_playoff: :boolean,
      uses_playoff_reseeding: :boolean,
      uses_roster_import: :boolean,
      waiver_rule: :atom,
      waiver_time: :integer,
      waiver_type: :atom
    ]

  def stat_categories(%{stats: stats}, _entity, _parent) do
    Enum.map(stats, &StatCategory.new(&1))
  end

  def stat_modifiers(%{stats: stats}) do
    Map.new(stats, fn %{stat: stat} ->
      {cast_integer(stat.stat_id), cast_float(stat.value)}
    end)
  end
end
