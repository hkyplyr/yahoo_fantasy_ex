defmodule YahooFantasyEx.Models.Player do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :display_position,
    :editorial_player_key,
    :editorial_team_abbr,
    :editorial_team_full_name,
    :editorial_team_key,
    :editorial_team_url,
    :eligible_positions,
    :has_player_notes,
    :image_url,
    :is_keeper,
    :is_undroppable,
    :name,
    :player_advanced_stats,
    :player_id,
    :player_key,
    :player_points,
    :player_stats,
    :player_notes_last_timestamp,
    :position_type,
    :primary_position,
    :status,
    :status_full,
    :uniform_number,
    :url
  ]

  @type t :: %__MODULE__{
          display_position: String.t(),
          editorial_player_key: String.t(),
          editorial_team_abbr: String.t(),
          editorial_team_full_name: String.t(),
          editorial_team_key: String.t(),
          editorial_team_url: String.t(),
          eligible_positions: [atom()],
          has_player_notes: boolean(),
          image_url: String.t(),
          is_keeper: boolean(),
          is_undroppable: boolean(),
          name: String.t(),
          player_advanced_stats: [Stat.t()],
          player_id: integer() | nil,
          player_key: String.t(),
          player_points: float() | nil,
          player_stats: [Stat.t()],
          player_notes_last_timestamp: integer() | nil,
          position_type: atom(),
          primary_position: atom(),
          status: atom() | nil,
          status_full: String.t(),
          uniform_number: integer() | nil,
          url: String.t()
        }

  @spec new(map() | tuple()) :: t() | nil
  def new({_, %{"player" => data}}) do
    data
    |> flatten_attributes()
    |> super()
    |> transform(
      eligible_positions: &parse_eligible_positions/1,
      has_player_notes: &cast_boolean/1,
      is_keeper: &parse_is_keeper/1,
      is_undroppable: &cast_boolean/1,
      name: &parse_name/1,
      player_advanced_stats: &Stat.new/1,
      player_id: &cast_integer/1,
      player_notes_last_timestamp: &cast_integer/1,
      player_points: &parse_player_points/1,
      player_stats: &Stat.new/1,
      position_type: &translate_position_type/1,
      primary_position: &translate_position/1,
      status: &translate_status/1,
      uniform_number: &cast_integer/1
    )
  end

  def new(_), do: nil

  defp parse_eligible_positions(eligible_positions) when is_list(eligible_positions) do
    Enum.map(eligible_positions, fn %{"position" => position} -> translate_position(position) end)
  end

  defp parse_eligible_positions(_), do: nil

  defp parse_is_keeper(%{"kept" => is_keeper}), do: is_keeper
  defp parse_is_keeper(_), do: nil

  defp parse_name(%{"full" => name}), do: name

  defp parse_player_points(%{"total" => player_points}), do: cast_float(player_points)
  defp parse_player_points(_), do: nil
end
