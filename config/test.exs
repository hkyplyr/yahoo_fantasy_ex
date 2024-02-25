import Config

config :yahoo_fantasy_ex,
  base_url: "http://localhost:7997",
  authorize_url: "http://localhost:7998",
  token_url: "http://localhost:7999"

config :bypass, enable_debug_log: true

config :logger, level: :debug
