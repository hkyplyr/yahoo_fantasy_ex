defmodule YahooFantasyEx.Models.HelpersTest do
  use ExUnit.Case

  alias YahooFantasyEx.Models.Helpers

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
  end

  describe "cast_atom/1" do
    test "converts atom correctly" do
      assert Helpers.cast_atom("atom") == :atom
    end
  end

  describe "cast_atom!/1" do
    test "converts atom correctly" do
      assert Helpers.cast_atom!("atom") == :atom
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
end
