defmodule YahooFantasyEx.Tokens do
  @moduledoc """
  TODO - add moduledoc
  """

  @type token :: %{
          access_token: String.t(),
          refresh_token: String.t(),
          expires_by: DateTime.t()
        }

  @callback get :: {:ok, token()} | :error
  @callback put(token()) :: :ok | :error

  @spec get :: {:ok, token()} | :error
  def get, do: impl().get()

  @spec put(token()) :: :ok | :error
  def put(value), do: impl().put(value)

  defp impl, do: Application.fetch_env!(:yahoo_fantasy_ex, :token_module)
end
