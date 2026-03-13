defmodule YahooFantasyEx.Tokens.Database do
  @moduledoc """
  TODO - add moduledoc
  """
  @behaviour YahooFantasyEx.Tokens

  alias YahooFantasyEx.Token

  @impl YahooFantasyEx.Tokens
  def get do
    case get_token() do
      nil -> :error
      token -> {:ok, Map.from_struct(token)}
    end
  end

  @impl YahooFantasyEx.Tokens
  def put(params) do
    get_token()
    |> upsert(params)
    |> case do
      {:ok, _token} -> :ok
      _error -> :error
    end
  end

  defp get_token, do: repo().one(Token)

  defp upsert(nil, params), do: repo().insert(Token.changeset(params))
  defp upsert(token, params), do: repo().update(Token.changeset(token, params))

  defp repo, do: Application.fetch_env!(:yahoo_fantasy_ex, :repo)
end
