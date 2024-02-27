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
               roster_positions: %{
                 center: %{type: :player, count: 2, starting: true},
                 left_wing: %{type: :player, count: 2, starting: true},
                 right_wing: %{type: :player, count: 2, starting: true},
                 forward: %{type: :player, count: 2, starting: true},
                 defense: %{type: :player, count: 4, starting: true},
                 goalie: %{type: :goalie, count: 2, starting: true},
                 bench: %{type: nil, count: 6, starting: false},
                 injured_reserve: %{type: nil, count: 2, starting: false},
                 injured_reserve_plus: %{type: nil, count: 3, starting: false}
               },
               stat_categories: [
                 %{
                   abbr: "G",
                   enabled: true,
                   group: :offense,
                   name: "Goals",
                   position_type: :player,
                   sort_order: :desc,
                   stat_id: 1
                 },
                 %{
                   abbr: "A",
                   enabled: true,
                   group: :offense,
                   name: "Assists",
                   position_type: :player,
                   sort_order: :desc,
                   stat_id: 2
                 },
                 %{
                   abbr: "PPP",
                   enabled: true,
                   group: :offense,
                   name: "Powerplay Points",
                   position_type: :player,
                   sort_order: :desc,
                   stat_id: 8
                 },
                 %{
                   abbr: "SHP",
                   enabled: true,
                   group: :offense,
                   name: "Shorthanded Points",
                   position_type: :player,
                   sort_order: :desc,
                   stat_id: 11
                 },
                 %{
                   abbr: "SOG",
                   enabled: true,
                   group: :offense,
                   name: "Shots on Goal",
                   position_type: :player,
                   sort_order: :desc,
                   stat_id: 14
                 },
                 %{
                   abbr: "HIT",
                   enabled: true,
                   group: :offense,
                   name: "Hits",
                   position_type: :player,
                   sort_order: :desc,
                   stat_id: 31
                 },
                 %{
                   abbr: "BLK",
                   enabled: true,
                   group: :offense,
                   name: "Blocks",
                   position_type: :player,
                   sort_order: :desc,
                   stat_id: 32
                 },
                 %{
                   abbr: "W",
                   enabled: true,
                   group: :goaltending,
                   name: "Wins",
                   position_type: :goalie,
                   sort_order: :desc,
                   stat_id: 19
                 },
                 %{
                   abbr: "L",
                   enabled: true,
                   group: :goaltending,
                   name: "Losses",
                   position_type: :goalie,
                   sort_order: :asc,
                   stat_id: 20
                 },
                 %{
                   abbr: "GA",
                   enabled: true,
                   group: :goaltending,
                   name: "Goals Against",
                   position_type: :goalie,
                   sort_order: :asc,
                   stat_id: 22
                 },
                 %{
                   abbr: "SV",
                   enabled: true,
                   group: :goaltending,
                   name: "Saves",
                   position_type: :goalie,
                   sort_order: :desc,
                   stat_id: 25
                 },
                 %{
                   abbr: "SHO",
                   enabled: true,
                   group: :goaltending,
                   name: "Shutouts",
                   position_type: :goalie,
                   sort_order: :desc,
                   stat_id: 27
                 }
               ],
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
