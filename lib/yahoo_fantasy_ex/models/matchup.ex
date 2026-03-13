defmodule YahooFantasyEx.Models.Matchup do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      is_consolation: :boolean,
      is_playoffs: :boolean,
      is_tied: :boolean,
      status: :atom,
      week: :integer,
      week_end: :string,
      week_start: :string,
      winner_team_key: :string,
      stat_winners: {:many, YahooFantasyEx.Models.Matchup.StatWinner},
      teams: {:many, YahooFantasyEx.Models.Team}
    ]
end
