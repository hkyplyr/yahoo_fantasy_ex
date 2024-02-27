defmodule YahooFantasyEx.Tokens do
  @moduledoc false

  def read, do: File.read(token_file())

  def write(value), do: File.write(token_file(), Jason.encode!(value))

  def token_file, do: Application.get_env(:yahoo_fantasy_ex, :token_file)
end
