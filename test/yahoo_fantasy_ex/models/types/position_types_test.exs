defmodule YahooFantasyEx.Models.Types.PositionTypesTest do
  use ExUnit.Case

  alias YahooFantasyEx.Models.Types.PositionTypes

  describe "translate_position_type/1" do
    test "returns expected atom for input" do
      assert PositionTypes.translate_position_type("P") == :player
      assert PositionTypes.translate_position_type("G") == :goalie
      assert PositionTypes.translate_position_type(nil) == nil
    end
  end
end
