defmodule YahooFantasyEx.Models.League.Settings.RosterPositionTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.League.Settings.RosterPosition

  describe "new/1" do
    test "returns a single roster position with valid data" do
      json = load_fixture("roster_position/roster_position.json")

      assert %{
               position: :center,
               position_type: :player,
               count: 2,
               is_starting_position: true
             } = RosterPosition.new(json)
    end
  end
end
