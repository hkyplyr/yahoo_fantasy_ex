defmodule YahooFantasyEx.Models.Transaction.PickTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Models.Transaction.Pick
  alias YahooFantasyEx.Models.Transaction.Pick

  describe "new/1" do
    test "test" do
      json = load_fixture("pick/pick.json")

      assert %Pick{
               destination_team_key: "419.l.6738.t.2",
               destination_team_name: "Team Two",
               original_team_key: "419.l.6738.t.1",
               original_team_name: "Team One",
               source_team_key: "419.l.6738.t.1",
               source_team_name: "Team One",
               round: 1
             } = Pick.new(json)
    end
  end
end
