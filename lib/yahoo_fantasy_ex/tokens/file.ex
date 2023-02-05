defmodule YahooFantasyEx.Tokens.File do
  @moduledoc false
  @behaviour YahooFantasyEx.Tokens.Manager

  @token_file ".tokens.json"

  def read do
    File.read(@token_file)
  end

  def write(value) do
    {:ok, file} = File.open(@token_file, [:write])
    IO.binwrite(file, Poison.encode!(value))
    File.close(file)
  end
end
