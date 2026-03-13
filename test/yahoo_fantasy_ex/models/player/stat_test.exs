defmodule YahooFantasyEx.Models.Player.StatTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.Player.Stat

  describe "new/1" do
    test "returns a single stat with valid data" do
      json = load_fixture("stat/stat.json")

      assert %{stat_id: 1, value: 2.5} = Stat.new(json)
    end
  end
end
