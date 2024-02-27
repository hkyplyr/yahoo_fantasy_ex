defmodule YahooFantasyEx.Models.PlayerTest do
  use YahooFantasyEx.BaseCase

  # alias YahooFantasyEx.Models.Player
  # alias YahooFantasyEx.Models.Player.Stat

  # describe "new/1" do
  # test "returns nil with invalid data" do
  #   assert nil == Player.new(nil)
  # end
  #
  # test "returns the list of players with valid data" do
  #   json = load_fixture("league/players.json")
  #
  #   assert [
  #            %{
  #              display_position: "C,LW",
  #              editorial_player_key: "nhl.p.1600",
  #              editorial_team_abbr: "FLA",
  #              editorial_team_full_name: "Florida Panthers",
  #              editorial_team_key: "nhl.t.26",
  #              editorial_team_url: "https://sports.yahoo.com/nhl/teams/florida/",
  #              eligible_positions: [:center, :left_wing, :forward],
  #              has_player_notes: true,
  #              image_url:
  #                "https://s.yimg.com/iu/api/res/1.2/2BxKblgmpe9hSlLr8yxr6Q--~C/YXBwaWQ9eXNwb3J0cztjaD0yMzM2O2NyPTE7Y3c9MTc5MDtkeD04NTc7ZHk9MDtmaT11bGNyb3A7aD02MDtxPTEwMDt3PTQ2/https://s.yimg.com/xe/i/us/sp/v/nhl_cutout/players_l/11082021/1600.png",
  #              is_keeper: false,
  #              is_undroppable: false,
  #              name: "Joe Thornton",
  #              player_advanced_stats: [
  #                %{stat_id: 1001, value: 0.0},
  #                %{stat_id: 1002, value: 0.0},
  #                %{stat_id: 1003, value: 0.0},
  #                %{stat_id: 1004, value: 0.0},
  #                %{stat_id: 1005, value: 0.0},
  #                %{stat_id: 1006, value: 0.0},
  #                %{stat_id: 1007, value: 0.0},
  #                %{stat_id: 1008, value: 0.0},
  #                %{stat_id: 1009, value: 0.0},
  #                %{stat_id: 1010, value: 0.0},
  #                %{stat_id: 1011, value: 0.0}
  #              ],
  #              player_id: 1600,
  #              player_key: "419.p.1600",
  #              player_points: 0.0,
  #              player_stats: [
  #                %{stat_id: 1, value: nil},
  #                %{stat_id: 2, value: nil},
  #                %{stat_id: 8, value: nil},
  #                %{stat_id: 11, value: nil},
  #                %{stat_id: 14, value: nil},
  #                %{stat_id: 31, value: nil},
  #                %{stat_id: 32, value: nil}
  #              ],
  #              player_notes_last_timestamp: 1_675_472_438,
  #              position_type: :player,
  #              primary_position: :center,
  #              status: :not_active,
  #              status_full: "Not Active",
  #              uniform_number: 19,
  #              url: "https://sports.yahoo.com/nhl/players/1600"
  #            },
  #            %{}
  #          ] = Enum.map(json, &Player.new/1)
  # end
  # end
end
