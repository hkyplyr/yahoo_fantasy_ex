defmodule YahooFantasyEx.Models.Types.PositionTypes do
  @moduledoc false

  @type t :: :player | :goalie | :invalid

  @spec translate_position_type(String.t(), any()) :: t()
  def translate_position_type("P", %{game_code: :mlb}), do: :pitcher
  def translate_position_type("P", _league), do: :player
  def translate_position_type("G", _league), do: :goalie
  def translate_position_type("O", _league), do: :offense
  def translate_position_type("D", _league), do: :defense
  def translate_position_type("K", _league), do: :kicker
  def translate_position_type("B", _league), do: :batter
  def translate_position_type(_, _league), do: :invalid
end
