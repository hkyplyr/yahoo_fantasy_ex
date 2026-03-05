defmodule YahooFantasyEx.Test.SQLiteRepo.Migrations.AddYahooTokens do
  use Ecto.Migration

  defdelegate up, to: YahooFantasyEx.Migrations.SQLite
  defdelegate down, to: YahooFantasyEx.Migrations.SQLite
end
