defmodule YahooFantasyEx.Models.Matchup.StatWinner do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      is_tied: :boolean,
      stat_id: :integer,
      winner_team_key: :string
    ]
end
