defmodule YahooFantasyEx.Models.Player.StatTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Models.Player.Stat
  alias YahooFantasyEx.Models.Player.Stat

  describe "new/1" do
    test "returns a single stat with valid data" do
      json = load_fixture("stat/stat.json")

      assert %Stat{stat_id: 1, value: 2.5} = Stat.new(json)
    end

    test "returns a list of stats with valid data" do
      json = load_fixture("stat/stats.json")

      assert [
               %Stat{stat_id: 19, value: 8.0},
               %Stat{stat_id: 20, value: 6.0},
               %Stat{stat_id: 22, value: 45.0},
               %Stat{stat_id: 25, value: 507.0},
               %Stat{stat_id: 27, value: 1.0}
             ] = Stat.new(json)
    end

    test "returns an empty list with invalid data" do
      assert [] = Stat.new(nil)
    end
  end
end
