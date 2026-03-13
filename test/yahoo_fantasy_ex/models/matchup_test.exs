defmodule YahooFantasyEx.Models.MatchupTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.Matchup

  describe "new/1" do
    test "returns the list of matchups with valid data" do
      json = load_fixture("league/scoreboard.json")

      assert [%{}, %{}] = Enum.map(json[:fantasy_content][:league], &Matchup.new/1)
    end
  end
end
