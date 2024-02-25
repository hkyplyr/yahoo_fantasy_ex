defmodule YahooFantasyEx.Models.Types.PositionTypesTest do
  use ExUnit.Case
  doctest YahooFantasyEx.Models.Types.PositionTypes
  alias YahooFantasyEx.Models.Types.PositionTypes

  describe "translate_position_type/1" do
    test "returns expected atom for input" do
      assert PositionTypes.translate_position_type("P", nil) == :player
      assert PositionTypes.translate_position_type("G", nil) == :goalie
      assert PositionTypes.translate_position_type(nil, nil) == :invalid
    end
  end
end
