defmodule YahooFantasyEx.Test.SQLiteRepo do
  @moduledoc false

  use Ecto.Repo, otp_app: :yahoo_fantasy_ex, adapter: Ecto.Adapters.SQLite3
end
