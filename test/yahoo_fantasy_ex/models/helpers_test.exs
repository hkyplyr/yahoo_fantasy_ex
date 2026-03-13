defmodule YahooFantasyEx.Models.HelpersTest do
  use ExUnit.Case

  alias YahooFantasyEx.Models.Helpers

  describe "cast_string/1" do
    test "converts false to nil" do
      assert Helpers.cast_string(false) == nil
    end

    test "returns everything else unchanged" do
      assert Helpers.cast_string(nil) == nil
      assert Helpers.cast_string("string") == "string"
    end
  end

  describe "cast_boolean/1" do
    test "converts truthy values correctly" do
      assert Helpers.cast_boolean("1")
      assert Helpers.cast_boolean(1)
      assert Helpers.cast_boolean(true)
    end

    test "converts falsy values correctly" do
      refute Helpers.cast_boolean("0")
      refute Helpers.cast_boolean(0)
      refute Helpers.cast_boolean(false)
      refute Helpers.cast_boolean(nil)
    end
  end

  describe "cast_integer/1" do
    test "converts integer correctly" do
      assert Helpers.cast_integer("-") == nil
      assert Helpers.cast_integer("") == nil
      assert Helpers.cast_integer(nil) == nil
      assert Helpers.cast_integer("10") == 10
      assert Helpers.cast_integer(100) == 100
    end
  end

  describe "cast_float/1" do
    test "converts float correctly" do
      assert Helpers.cast_float("-") == nil
      assert Helpers.cast_float("1") == 1.0
      assert Helpers.cast_float(1.0) == 1.0
      assert Helpers.cast_float(0) == 0.0
      assert Helpers.cast_float(".333") == 0.333
    end

    test "converts invalid float to nil" do
      assert Helpers.cast_float("text") == nil
    end
  end

  describe "cast_atom/1" do
    test "converts atom correctly" do
      assert Helpers.cast_atom("atom") == :atom
    end
  end

  describe "cast_atom!/1" do
    test "converts atom correctly" do
      assert Helpers.cast_atom!(nil) == nil
      assert Helpers.cast_atom!("atom") == :atom
    end
  end

  describe "cast_date/1" do
    test "converts date correctly" do
      assert Helpers.cast_date(nil) == nil
      assert Helpers.cast_date("2026-01-01") == ~D[2026-01-01]
    end
  end

  describe "translate_sort_order/1" do
    test "convert sort order correctly" do
      assert Helpers.translate_sort_order("1") == :desc
      assert Helpers.translate_sort_order("0") == :asc
    end
  end

  describe "translate_status/1" do
    test "convert status correctly" do
      assert Helpers.translate_status("NA") == :not_active
      assert Helpers.translate_status("IR-LT") == :long_term_injured_reserve
      assert Helpers.translate_status("IR") == :injured_reserve
      assert Helpers.translate_status("O") == :out
      assert Helpers.translate_status("DTD") == :day_to_day
      assert Helpers.translate_status("IR-NR") == :non_roster_injured_reserve
      assert Helpers.translate_status(nil) == nil
    end
  end

  describe "transform/2" do
    assert %{total: 1} = Helpers.transform(%{total: 0}, total: &(&1 + 1))
  end

  describe "translate_position/1" do
    test "returns expected atom for input" do
      assert Helpers.translate_position("C") == :center
      assert Helpers.translate_position("LW") == :left_wing
      assert Helpers.translate_position("RW") == :right_wing
      assert Helpers.translate_position("W") == :winger
      assert Helpers.translate_position("F") == :forward
      assert Helpers.translate_position("Util") == :utility
      assert Helpers.translate_position("D") == :defense
      assert Helpers.translate_position("G") == :goalie

      assert Helpers.translate_position("QB") == :quarterback
      assert Helpers.translate_position("WR") == :wide_receiver
      assert Helpers.translate_position("RB") == :running_back
      assert Helpers.translate_position("TE") == :tight_end
      assert Helpers.translate_position("W/R/T") == :flex
      assert Helpers.translate_position("K") == :kicker
      assert Helpers.translate_position("DEF") == :defense

      assert Helpers.translate_position("PG") == :point_guard
      assert Helpers.translate_position("SG") == :shooting_guard
      assert Helpers.translate_position("SF") == :small_forward
      assert Helpers.translate_position("PF") == :power_forward

      assert Helpers.translate_position("IL") == :injured_list
      assert Helpers.translate_position("IL+") == :injured_list_plus
      assert Helpers.translate_position("BN") == :bench
      assert Helpers.translate_position("NA") == :not_active
      assert Helpers.translate_position("IR") == :injured_reserve
      assert Helpers.translate_position("IR+") == :injured_reserve_plus

      assert Helpers.translate_position(nil) == nil
      assert Helpers.translate_position("UNK") == :invalid
    end
  end

  describe "translate_position_type/1" do
    test "returns expected atom for input" do
      assert Helpers.translate_position_type("P") == :player
      assert Helpers.translate_position_type("G") == :goalie

      assert Helpers.translate_position_type("O") == :offense
      assert Helpers.translate_position_type("D") == :defense
      assert Helpers.translate_position_type("K") == :kicker

      assert Helpers.translate_position_type("B") == :batter

      assert Helpers.translate_position_type(nil) == nil
      assert Helpers.translate_position_type("UNK") == :invalid
    end
  end

  describe "translate_transaction_type/1" do
    test "returns expected atom for input" do
      assert Helpers.translate_transaction_type("add/drop") == :add_drop
      assert Helpers.translate_transaction_type("add") == :add
      assert Helpers.translate_transaction_type("drop") == :drop
      assert Helpers.translate_transaction_type("trade") == :trade
    end
  end
end
