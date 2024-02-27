defmodule YahooFantasyEx.Models.Player do
  @moduledoc false

  use YahooFantasyEx.Model,
    fields: [
      display_position: :string,
      editorial_player_key: :string,
      editorial_team_abbr: :string,
      editorial_team_full_name: :string,
      editorial_team_key: :string,
      editorial_team_url: :string,
      eligible_positions: {:array, &Player.eligible_positions/1},
      has_player_notes: :boolean,
      image_url: :string,
      is_keeper: &Player.is_keeper/1,
      is_undroppable: :boolean,
      name: &Player.name/1,
      player_id: :integer,
      player_key: :string,
      player_notes_last_timestamp: :integer,
      position_type: &Player.position_type/1,
      primary_position: &Player.primary_position/1,
      status_full: :string,
      url: :string,
      uniform_number: :integer,
      status: &Player.status/1,
      player_advanced_stats: &Player.stats/1,
      player_points: &Player.points/1,
      player_stats: &Player.stats/1
    ]

  alias YahooFantasyEx.Models.Helpers
  alias YahooFantasyEx.Models.Types.Positions
  alias YahooFantasyEx.Models.Types.PositionTypes

  @spec name(map()) :: String.t()
  def name(%{full: name}), do: name

  @spec eligible_positions(map()) :: atom()
  def eligible_positions(%{position: position}), do: Positions.translate_position(position)

  def is_keeper(%{kept: is_keeper}), do: is_keeper

  def primary_position(position), do: Positions.translate_position(position)

  def position_type(position_type), do: PositionTypes.translate_position_type(position_type)

  def status(status), do: Helpers.translate_status(status)

  def points(%{total: player_points}), do: cast_float(player_points)

  def stats(%{stats: stats}) do
    Enum.map(stats, fn %{stat: stat} ->
      %{stat_id: cast_integer(stat.stat_id), value: cast_float(stat.value)}
    end)
  end
end
