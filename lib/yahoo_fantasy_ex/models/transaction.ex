defmodule YahooFantasyEx.Models.Transaction do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      status: :atom,
      type: &translate_transaction_type/1,
      timestamp: :integer,
      tradee_team_key: :string,
      trader_team_key: :string,
      transaction_key: :string,
      players: {:many, YahooFantasyEx.Models.Player},
      picks: {:many, YahooFantasyEx.Models.Transaction.Pick}
    ]
end
