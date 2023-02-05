defmodule YahooFantasyEx.Models.Types.PositionsTest do
  use ExUnit.Case
  doctest YahooFantasyEx.Models.Types.Positions
  alias YahooFantasyEx.Models.Types.Positions

  describe "translate_position/1" do
    test "returns expected atom for input" do
      assert Positions.translate_position("C") == :center
      assert Positions.translate_position("LW") == :left_wing
      assert Positions.translate_position("RW") == :right_wing
      assert Positions.translate_position("F") == :forward
      assert Positions.translate_position("D") == :defense
      assert Positions.translate_position("G") == :goalie
      assert Positions.translate_position("BN") == :bench
      assert Positions.translate_position("IR") == :injured_reserve
      assert Positions.translate_position("IR+") == :injured_reserve_plus
      assert Positions.translate_position(nil) == :invalid
    end
  end
end
