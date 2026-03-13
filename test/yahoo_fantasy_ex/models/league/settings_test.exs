defmodule YahooFantasyEx.Models.League.SettingsTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.League.Settings

  describe "new/1" do
    test "returns settings for valid data" do
      json = load_fixture("league/settings.json")

      assert %{
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
               roster_import_deadline: ~D[2022-10-01],
               scoring_type: :headpoint,
               sendbird_channel_url: "sendbird_channel_url",
               trade_end_date: ~D[2023-02-22],
               trade_ratify_type: :commish,
               trade_reject_time: 1,
               uses_faab: true,
               uses_lock_eliminated_teams: false,
               uses_playoff: true,
               uses_playoff_reseeding: true,
               uses_roster_import: true,
               waiver_rule: :all,
               waiver_time: 2,
               waiver_type: :FR,
               roster_positions: [
                 %{
                   position: :center,
                   position_type: :player,
                   count: 2,
                   is_starting_position: true
                 },
                 %{
                   position: :left_wing,
                   position_type: :player,
                   count: 2,
                   is_starting_position: true
                 },
                 %{
                   position: :right_wing,
                   position_type: :player,
                   count: 2,
                   is_starting_position: true
                 },
                 %{
                   position: :forward,
                   position_type: :player,
                   count: 2,
                   is_starting_position: true
                 },
                 %{
                   position: :defense,
                   position_type: :player,
                   count: 4,
                   is_starting_position: true
                 },
                 %{
                   position: :goalie,
                   position_type: :goalie,
                   count: 2,
                   is_starting_position: true
                 },
                 %{position: :bench, position_type: nil, count: 6, is_starting_position: false},
                 %{
                   position: :injured_reserve,
                   position_type: nil,
                   count: 2,
                   is_starting_position: false
                 },
                 %{
                   position: :injured_reserve_plus,
                   position_type: nil,
                   count: 3,
                   is_starting_position: false
                 }
               ],
               stat_categories: _stat_categories,
               stat_modifiers: %{
                 1 => 3.5,
                 2 => 2.5,
                 8 => 1.0,
                 11 => 1.25,
                 14 => 0.3,
                 19 => 4.0,
                 20 => -2.0,
                 22 => -1.0,
                 25 => 0.2,
                 27 => 3.0,
                 31 => 0.25,
                 32 => 0.25
               }
             } = Settings.new(hd(tl(json[:fantasy_content][:league]))[:settings])
    end
  end
end
