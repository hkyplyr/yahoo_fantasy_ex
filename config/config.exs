import Config

config :yahoo_fantasy_ex,
  client_id: System.get_env("YAHOO_CLIENT_ID"),
  client_secret: System.get_env("YAHOO_CLIENT_SECRET")

import_config "#{Mix.env()}.exs"
