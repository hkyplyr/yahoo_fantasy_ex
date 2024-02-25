defmodule YahooFantasyEx.Models.League.Settings.StatCategory do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :abbr,
    :display_name,
    :enabled,
    :group,
    :name,
    :position_type,
    :sort_order,
    :stat_id
  ]

  @type t :: %__MODULE__{
          abbr: String.t(),
          display_name: String.t(),
          enabled: boolean(),
          group: atom(),
          name: String.t(),
          position_type: atom(),
          sort_order: :asc | :desc,
          stat_id: integer()
        }

  @spec new(map(), League.t()) :: t()
  def new(%{"stat" => data}, league) do
    data
    |> super([])
    |> transform(
      enabled: &cast_boolean/1,
      group: &cast_atom!/1,
      position_type: &translate_position_type(&1, league),
      sort_order: &translate_sort_order/1,
      stat_id: &cast_integer/1
    )
  end
end
