defmodule YahooFantasyEx.Models.League.Settings.StatModifier do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      stat_id: :integer,
      value: :float
    ]
end
