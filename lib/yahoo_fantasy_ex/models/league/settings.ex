defmodule YahooFantasyEx.Models.League.Settings do
  @moduledoc false

  alias YahooFantasyEx.Models.League.Settings
  alias YahooFantasyEx.Models.League.Settings.StatCategory
  alias YahooFantasyEx.Models.Types.Positions
  alias YahooFantasyEx.Models.Types.PositionTypes

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
      roster_positions: &Settings.roster_positions/1,
      scoring_type: :atom,
      sendbird_channel_url: :string,
      stat_categories: &Settings.stat_categories/3,
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

  def roster_positions(roster_positions) do
    Map.new(roster_positions, fn %{roster_position: roster_position} ->
      position_type = Map.get(roster_position, :position_type)

      value = %{
        type: PositionTypes.translate_position_type(position_type),
        count: cast_integer(roster_position.count),
        starting: cast_boolean(roster_position.is_starting_position)
      }

      {Positions.translate_position(roster_position.position), value}
    end)
  end

  def stat_categories(%{stats: stats}, entity, parent) do
    Enum.map(stats, &StatCategory.build(&1, entity, parent))
  end

  def stat_modifiers(%{stats: stats}) do
    Map.new(stats, fn %{stat: stat} ->
      {cast_integer(stat.stat_id), cast_float(stat.value)}
    end)
  end
end
