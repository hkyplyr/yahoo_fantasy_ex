defmodule YahooFantasyEx.Models.League.Settings.StatCategory do
  @moduledoc false
  alias YahooFantasyEx.Models.Types.PositionTypes
  use YahooFantasyEx, :model

  @type t :: %{
          abbr: String.t(),
          display_name: String.t(),
          enabled: boolean(),
          group: atom(),
          name: String.t(),
          position_type: atom(),
          sort_order: :asc | :desc,
          stat_id: integer()
        }

  @spec build(map(), map(), map()) :: map()
  def build(%{stat: stat}, _entity, _parent) do
    transform(stat,
      abbr: &Function.identity/1,
      enabled: &cast_boolean/1,
      group: &cast_atom!/1,
      name: &Function.identity/1,
      position_type: &PositionTypes.translate_position_type/1,
      sort_order: &translate_sort_order/1,
      stat_id: &cast_integer/1
    )
  end
end
