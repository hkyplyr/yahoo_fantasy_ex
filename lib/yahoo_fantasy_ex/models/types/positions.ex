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
  def translate_position("F"), do: :forward
  def translate_position("D"), do: :defense
  def translate_position("G"), do: :goalie
  def translate_position("BN"), do: :bench
  def translate_position("IR"), do: :injured_reserve
  def translate_position("IR+"), do: :injured_reserve_plus
  def translate_position(_), do: :invalid
end
