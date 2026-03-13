defmodule YahooFantasyEx.Models.Player.Stat do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      stat_id: :integer,
      value: :float
    ]
end
