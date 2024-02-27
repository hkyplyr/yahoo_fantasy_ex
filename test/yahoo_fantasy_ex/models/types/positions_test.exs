defmodule YahooFantasyEx.Models.Types.PositionsTest do
  use ExUnit.Case

  alias YahooFantasyEx.Models.Types.Positions

  describe "translate_position/1" do
    test "returns expected atom for input" do
      assert Positions.translate_position("C") == :center
      assert Positions.translate_position("LW") == :left_wing
      assert Positions.translate_position("RW") == :right_wing
      assert Positions.translate_position("W") == :winger
      assert Positions.translate_position("F") == :forward
      assert Positions.translate_position("Util") == :utility
      assert Positions.translate_position("D") == :defense
      assert Positions.translate_position("G") == :goalie

      assert Positions.translate_position("QB") == :quarterback
      assert Positions.translate_position("WR") == :wide_receiver
      assert Positions.translate_position("RB") == :running_back
      assert Positions.translate_position("TE") == :tight_end
      assert Positions.translate_position("W/R/T") == :flex
      assert Positions.translate_position("K") == :kicker
      assert Positions.translate_position("DEF") == :defense

      assert Positions.translate_position("PG") == :point_guard
      assert Positions.translate_position("SG") == :shooting_guard
      assert Positions.translate_position("SF") == :small_forward
      assert Positions.translate_position("PF") == :power_forward

      assert Positions.translate_position("IL") == :injured_list
      assert Positions.translate_position("IL+") == :injured_list_plus
      assert Positions.translate_position("BN") == :bench
      assert Positions.translate_position("NA") == :not_active
      assert Positions.translate_position("IR") == :injured_reserve
      assert Positions.translate_position("IR+") == :injured_reserve_plus

      assert Positions.translate_position(nil) == nil
      assert Positions.translate_position("UNK") == :invalid
    end
  end
end
