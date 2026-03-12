import Config

config :yahoo_fantasy_ex,
  authorize_url: "http://localhost:7998",
  base_url: "http://localhost:7997",
  token_url: "http://localhost:7999",
  client_id: "yahoo_client_id",
  client_secret: "yahoo_client_secret"

config :yahoo_fantasy_ex, YahooFantasyEx.Test.SQLiteRepo,
  database: "priv/yahoo_fantasy_ex.db",
  priv: "test/support/sqlite",
  stacktrace: true,
  temp_store: :memory,
  log: false

config :yahoo_fantasy_ex, ecto_repos: [YahooFantasyEx.Test.SQLiteRepo]
