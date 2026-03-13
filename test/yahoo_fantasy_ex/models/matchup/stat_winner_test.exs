defmodule YahooFantasyEx.Models.Matchup.StatWinnerTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.Matchup.StatWinner

  describe "new/1" do
    test "returns a single stat winner with valid data" do
      json = load_fixture("stat_winner/stat_winner.json")

      assert %{
               is_tied: false,
               stat_id: 1,
               winner_team_key: "nhl.l.12345.t.5"
             } = StatWinner.new(json)
    end
  end
end
