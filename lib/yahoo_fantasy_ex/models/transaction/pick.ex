defmodule YahooFantasyEx.Models.Transaction.Pick do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      destination_team_key: :string,
      destination_team_name: :string,
      original_team_key: :string,
      original_team_name: :string,
      round: :integer,
      source_team_key: :string,
      source_team_name: :string
    ]
end
