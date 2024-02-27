defmodule YahooFantasyEx.Models.TransactionTest do
  use YahooFantasyEx.BaseCase

  # alias YahooFantasyEx.Models.Player
  # alias YahooFantasyEx.Models.Transaction
  # alias YahooFantasyEx.Models.Transaction.Pick

  # describe "new/1" do
  #   test "returns nil with invalid data" do
  #     assert nil == Transaction.new(nil)
  #   end
  #
  #   test "returns the list of transactions with valid data" do
  #     json = load_fixture("league/transactions.json")
  #
  #     assert [
  #              %Transaction{
  #                transaction_key: "nhl.l.12345.tr.470",
  #                type: :add,
  #                status: :successful,
  #                timestamp: 1_675_472_438,
  #                players: [
  #                  %{
  #                    player_key: "419.p.5783",
  #                    player_id: 5783,
  #                    name: "Erik Gustafsson",
  #                    editorial_team_abbr: "WSH",
  #                    display_position: "D",
  #                    position_type: :player
  #                  }
  #                ]
  #              },
  #              %Transaction{
  #                transaction_key: "nhl.l.12345.tr.469",
  #                type: :add_drop,
  #                status: :successful,
  #                timestamp: 1_675_352_982,
  #                players: [
  #                  %{
  #                    player_key: "419.p.6390",
  #                    player_id: 6390,
  #                    name: "Jared McCann",
  #                    editorial_team_abbr: "SEA",
  #                    display_position: "C,LW",
  #                    position_type: :player
  #                  },
  #                  %{
  #                    player_key: "419.p.5024",
  #                    player_id: 5024,
  #                    name: "Calle Jarnkrok",
  #                    editorial_team_abbr: "TOR",
  #                    display_position: "C,LW,RW",
  #                    position_type: :player
  #                  }
  #                ]
  #              },
  #              %Transaction{
  #                transaction_key: "nhl.l.12345.tr.466",
  #                type: :trade,
  #                status: :successful,
  #                timestamp: 1_675_155_236,
  #                trader_team_key: "nhl.l.12345.t.8",
  #                tradee_team_key: "nhl.l.12345.t.10",
  #                players: [
  #                  %{player_id: 5024},
  #                  %{player_id: 5254},
  #                  %{player_id: 7920},
  #                  %{player_id: 4471},
  #                  %{player_id: 4472},
  #                  %{player_id: 4474}
  #                ],
  #                picks: [
  #                  %{round: 1, original_team_name: "Team One"},
  #                  %{round: 6, original_team_name: "Team One"},
  #                  %{round: 8, original_team_name: "Team One"},
  #                  %{round: 7, original_team_name: "Team Three"},
  #                  %{round: 13, original_team_name: "Team Three"},
  #                  %{round: 16, original_team_name: "Team Three"}
  #                ]
  #              },
  #              %Transaction{
  #                transaction_key: "nhl.l.12345.tr.463",
  #                type: :drop,
  #                status: :successful,
  #                timestamp: 1_675_063_822,
  #                players: [
  #                  %{
  #                    player_key: "419.p.5329",
  #                    player_id: 5329,
  #                    name: "Mattias Ekholm",
  #                    editorial_team_abbr: "NSH",
  #                    display_position: "D",
  #                    position_type: :player
  #                  }
  #                ]
  #              }
  #            ] = Enum.map(json, &Transaction.new/1)
  #   end
  # end
end
