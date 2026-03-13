defmodule YahooFantasyEx.Models.League.DraftResult do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      pick: :integer,
      player_key: :string,
      round: :integer,
      team_key: :string
    ]
end
