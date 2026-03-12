defmodule YahooFantasyEx.Tokens.File do
  @moduledoc """
  TODO - add moduledoc
  """
  @behaviour YahooFantasyEx.Tokens

  @token_file ".tokens.json"

  @impl YahooFantasyEx.Tokens
  def get do
    with {:ok, binary} <- File.read(token_file()),
         {:ok, %{expires_by: expires_by} = token} <- Jason.decode(binary, keys: :atoms),
         {:ok, parsed_expires_by, _offset} <- DateTime.from_iso8601(expires_by) do
      {:ok, Map.put(token, :expires_by, parsed_expires_by)}
    else
      _error -> :error
    end
  end

  @impl YahooFantasyEx.Tokens
  def put(value), do: File.write(token_file(), Jason.encode!(value))

  defp token_file, do: Application.get_env(:yahoo_fantasy_ex, :token_file, @token_file)
end
