defmodule YahooFantasyEx.Models.League.DraftResultTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Models.League.DraftResult

  alias YahooFantasyEx.Models.League.DraftResult
  alias YahooFantasyEx.Models.Player

  describe "new/1" do
    test "returns DraftResult for valid data" do
      json = load_fixture("league/draftresults.json")

      assert [
               %DraftResult{
                 pick: 1,
                 round: 1,
                 team_key: "419.l.6738.t.7",
                 player_key: "419.p.6743"
               },
               %DraftResult{
                 pick: 2,
                 round: 1,
                 team_key: "419.l.6738.t.12",
                 player_key: "419.p.7519",
                 player: %Player{player_id: 7519}
               }
             ] = Enum.map(json, &DraftResult.new/1)
    end
  end
end
