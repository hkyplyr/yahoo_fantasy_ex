defmodule YahooFantasyEx.Models.League.Settings.RosterPosition do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      count: :integer,
      is_starting_position: :boolean,
      position: &translate_position/1,
      position_type: &translate_position_type/1
    ]
end
