defmodule YahooFantasyEx.Models.League.Settings do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :can_trade_draft_picks,
    :cant_cut_list,
    :draft_pick_time,
    :draft_time,
    :draft_together,
    :draft_type,
    :has_multiweek_championship,
    :has_playoff_consolation_games,
    :is_auction_draft,
    :max_teams,
    :max_weekly_adds,
    :min_games_played,
    :num_playoff_consolation_teams,
    :num_playoff_teams,
    :persistent_url,
    :player_pool,
    :playoff_start_week,
    :post_draft_players,
    :roster_import_deadline,
    :roster_positions,
    :scoring_type,
    :sendbird_channel_url,
    :stat_categories,
    :stat_modifiers,
    :trade_end_date,
    :trade_ratify_type,
    :trade_reject_time,
    :uses_faab,
    :uses_lock_eliminated_teams,
    :uses_playoff,
    :uses_playoff_reseeding,
    :uses_roster_import,
    :waiver_rule,
    :waiver_time,
    :waiver_type
  ]

  @type t :: %__MODULE__{
          can_trade_draft_picks: boolean(),
          cant_cut_list: atom(),
          draft_pick_time: integer(),
          draft_time: integer(),
          draft_together: boolean(),
          draft_type: atom(),
          has_multiweek_championship: boolean(),
          has_playoff_consolation_games: boolean(),
          is_auction_draft: boolean(),
          max_teams: integer(),
          max_weekly_adds: integer(),
          min_games_played: integer() | nil,
          num_playoff_consolation_teams: integer(),
          num_playoff_teams: integer(),
          persistent_url: String.t(),
          player_pool: atom(),
          playoff_start_week: integer(),
          post_draft_players: atom(),
          roster_import_deadline: Date.t(),
          roster_positions: [RosterPosition.t()],
          scoring_type: atom(),
          sendbird_channel_url: String.t(),
          stat_categories: [StatCategory.t()],
          stat_modifiers: [StatModifier.t()],
          trade_end_date: Date.t(),
          trade_ratify_type: atom(),
          trade_reject_time: integer(),
          uses_faab: boolean(),
          uses_lock_eliminated_teams: boolean(),
          uses_playoff: boolean(),
          uses_playoff_reseeding: boolean(),
          uses_roster_import: boolean(),
          waiver_rule: atom(),
          waiver_time: integer(),
          waiver_type: atom()
        }

  @spec new(map()) :: t()
  def new(settings) do
    settings
    |> flatten()
    |> super()
    |> transform(
      can_trade_draft_picks: &cast_boolean/1,
      cant_cut_list: &cast_atom!/1,
      draft_pick_time: &cast_integer/1,
      draft_time: &cast_integer/1,
      draft_together: &cast_boolean/1,
      draft_type: &cast_atom!/1,
      has_multiweek_championship: &cast_boolean/1,
      has_playoff_consolation_games: &cast_boolean/1,
      is_auction_draft: &cast_boolean/1,
      max_teams: &cast_integer/1,
      max_weekly_adds: &cast_integer/1,
      min_games_played: &cast_integer/1,
      num_playoff_consolation_teams: &cast_integer/1,
      num_playoff_teams: &cast_integer/1,
      player_pool: &cast_atom!/1,
      playoff_start_week: &cast_integer/1,
      post_draft_players: &cast_atom!/1,
      roster_import_deadline: &cast_date/1,
      roster_positions: &parse_roster_positions/1,
      scoring_type: &cast_atom!/1,
      stat_categories: &parse_stat_categories/1,
      stat_modifiers: &parse_stat_modifiers/1,
      trade_end_date: &cast_date/1,
      trade_ratify_type: &cast_atom!/1,
      trade_reject_time: &cast_integer/1,
      uses_faab: &cast_boolean/1,
      uses_lock_eliminated_teams: &cast_boolean/1,
      uses_playoff: &cast_boolean/1,
      uses_playoff_reseeding: &cast_boolean/1,
      uses_roster_import: &cast_boolean/1,
      waiver_rule: &cast_atom!/1,
      waiver_time: &cast_integer/1,
      waiver_type: &cast_atom!/1
    )
  end

  defp flatten(settings) do
    Enum.reduce(settings, &Map.merge(&2, &1))
  end

  defp parse_roster_positions(roster_positions) do
    Enum.map(roster_positions, &RosterPosition.new/1)
  end

  defp parse_stat_categories(stat_categories) do
    stat_categories
    |> Map.get("stats")
    |> Enum.map(&StatCategory.new/1)
  end

  defp parse_stat_modifiers(stat_modifiers) do
    stat_modifiers
    |> Map.get("stats")
    |> Enum.map(&StatModifier.new/1)
  end
end
