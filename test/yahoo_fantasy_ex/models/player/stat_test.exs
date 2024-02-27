defmodule YahooFantasyEx.Models.Player.StatTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.Player.Stat

  describe "new/1" do
    test "returns a single stat with valid data" do
      json = load_fixture("stat/stat.json")

      assert %{stat_id: 1, value: 2.5} = Stat.new(json)
    end

    test "returns a list of stats with valid data" do
      json = load_fixture("stat/stats.json")

      assert [
               %{stat_id: 19, value: 8.0},
               %{stat_id: 20, value: 6.0},
               %{stat_id: 22, value: 45.0},
               %{stat_id: 25, value: 507.0},
               %{stat_id: 27, value: 1.0}
             ] = Enum.map(json[:stats], &Stat.new(&1))
    end
  end
end
