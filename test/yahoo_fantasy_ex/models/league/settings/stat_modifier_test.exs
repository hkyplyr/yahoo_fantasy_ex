defmodule YahooFantasyEx.Models.League.Settings.StatModifierTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.League.Settings.StatModifier

  describe "new/1" do
    test "returns a single stat modifier with valid data" do
      json = load_fixture("stat_modifier/stat_modifier.json")

      assert %{stat_id: 1, value: 3.5} = StatModifier.new(json)
    end
  end
end
