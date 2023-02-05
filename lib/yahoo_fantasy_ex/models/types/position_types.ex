defmodule YahooFantasyEx.Models.Types.PositionTypes do
  @moduledoc false

  @type t :: :player | :goalie | :invalid

  @spec translate_position_type(String.t()) :: t()
  def translate_position_type("P"), do: :player
  def translate_position_type("G"), do: :goalie
  def translate_position_type(_), do: :invalid
end
