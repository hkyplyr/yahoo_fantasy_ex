import Config

config :yahoo_fantasy_ex,
  base_url: "https://fantasysports.yahooapis.com/fantasy/v2",
  authorize_url: "https://api.login.yahoo.com/oauth2/request_auth",
  token_url: "https://api.login.yahoo.com/oauth2/get_token"

import_config "#{Mix.env()}.exs"
