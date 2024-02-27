defmodule YahooFantasyEx.Models.Types.PositionTypes do
  @moduledoc false

  @type t :: :player | :goalie | :invalid

  @spec translate_position_type(String.t()) :: t()
  def translate_position_type("P"), do: :player
  def translate_position_type("G"), do: :goalie
  def translate_position_type("O"), do: :offense
  def translate_position_type("D"), do: :defense
  def translate_position_type("K"), do: :kicker
  def translate_position_type("B"), do: :batter
  def translate_position_type(nil), do: nil
  def translate_position_type(_), do: :invalid
end
