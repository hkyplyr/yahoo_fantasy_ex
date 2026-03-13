defmodule YahooFantasyEx.Models.League.DraftResultTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.League

  describe "new/1" do
    test "returns DraftResult for valid data" do
      json = load_fixture("league/draftresults.json")

      assert [
               %{
                 pick: 1,
                 round: 1,
                 team_key: "nhl.l.12345.t.10",
                 player_key: "nhl.p.5980"
               },
               %{
                 pick: 2,
                 round: 1,
                 team_key: "nhl.l.12345.t.7",
                 player_key: "nhl.p.7109"
               }
             ] = League.new(json[:fantasy_content][:league]).draft_results
    end
  end
end
