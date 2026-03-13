defmodule YahooFantasyEx.Models.League.Settings.StatCategory do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      abbr: :string,
      display_name: :string,
      enabled: :boolean,
      group: :atom,
      name: :string,
      position_type: &translate_position_type/1,
      sort_order: &translate_sort_order/1,
      stat_id: :integer
    ]
end
