defmodule YahooFantasyEx.Models.Types.Positions do
  @moduledoc false

  @type t ::
          :center
          | :left_wing
          | :right_wing
          | :forward
          | :defense
          | :goalie
          | :bench
          | :injured_reserve
          | :injured_reserve_plus
          | :invalid

  @spec translate_position(String.t()) :: t()
  def translate_position("C"), do: :center
  def translate_position("LW"), do: :left_wing
  def translate_position("RW"), do: :right_wing
  def translate_position("W"), do: :winger
  def translate_position("F"), do: :forward
  def translate_position("Util"), do: :utility
  def translate_position("D"), do: :defense
  def translate_position("G"), do: :goalie

  def translate_position("QB"), do: :quarterback
  def translate_position("WR"), do: :wide_receiver
  def translate_position("RB"), do: :running_back
  def translate_position("TE"), do: :tight_end
  def translate_position("W/R/T"), do: :flex
  def translate_position("K"), do: :kicker
  def translate_position("DEF"), do: :defense

  def translate_position("PG"), do: :point_guard
  def translate_position("SG"), do: :shooting_guard
  def translate_position("SF"), do: :small_forward
  def translate_position("PF"), do: :power_forward
  def translate_position("IL"), do: :injured_list
  def translate_position("IL+"), do: :injured_list_plus

  def translate_position("BN"), do: :bench
  def translate_position("NA"), do: :not_active
  def translate_position("IR"), do: :injured_reserve
  def translate_position("IR+"), do: :injured_reserve_plus
  def translate_position(_), do: :invalid
end
