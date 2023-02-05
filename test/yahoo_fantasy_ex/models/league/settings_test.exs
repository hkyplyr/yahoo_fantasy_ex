defmodule YahooFantasyEx.Models.League.SettingsTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Models.League.Settings
  alias YahooFantasyEx.Models.League.Settings

  describe "new/1" do
    test "returns settings for valid data" do
      json = load_fixture("league/settings.json")

      assert %Settings{
               can_trade_draft_picks: true,
               cant_cut_list: :none,
               draft_pick_time: 60,
               draft_time: 1_664_843_400,
               draft_together: false,
               draft_type: :live,
               has_multiweek_championship: false,
               has_playoff_consolation_games: true,
               is_auction_draft: false,
               max_teams: 12,
               max_weekly_adds: 3,
               min_games_played: nil,
               num_playoff_consolation_teams: 6,
               num_playoff_teams: 6,
               persistent_url: "https://hockey.fantasysports.yahoo.com/league/persistent",
               player_pool: :ALL,
               playoff_start_week: 22,
               post_draft_players: :W,
               roster_import_deadline: "2022-10-01",
               scoring_type: :headpoint,
               sendbird_channel_url: "sendbird_channel_url",
               trade_end_date: "2023-02-22",
               trade_ratify_type: :commish,
               trade_reject_time: 1,
               uses_faab: true,
               uses_lock_eliminated_teams: false,
               uses_playoff: true,
               uses_playoff_reseeding: true,
               uses_roster_import: true,
               waiver_rule: :all,
               waiver_time: 2,
               waiver_type: :FR
             } = Settings.new(json)
    end
  end
end
