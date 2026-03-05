import Config

config :yahoo_fantasy_ex,
  base_url: "http://localhost:7997",
  authorize_url: "http://localhost:7998",
  token_url: "http://localhost:7999"

config :yahoo_fantasy_ex, YahooFantasyEx.Test.SQLiteRepo,
  database: "priv/yahoo_fantasy_ex.db",
  priv: "test/support/sqlite",
  stacktrace: true,
  temp_store: :memory,
  log: false

config :yahoo_fantasy_ex, ecto_repos: [YahooFantasyEx.Test.SQLiteRepo]
