defmodule YahooFantasyEx.Models.Player.Stat do
  @moduledoc false
  use YahooFantasyEx, :model

  def new(%{stat: %{stat_id: stat_id, value: value}}) do
    %{stat_id: cast_integer(stat_id), value: cast_float(value)}
  end
end
