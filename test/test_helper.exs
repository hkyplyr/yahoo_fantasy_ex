ExUnit.start()
ExUnit.configure(exclude: :ci_only)

Mox.defmock(HTTPoison.BaseMock, for: HTTPoison.Base)
Mox.defmock(YahooFantasyEx.Tokens.ManagerMock, for: YahooFantasyEx.Tokens.Manager)

defmodule FakeIO do
  def gets("Code: "), do: "API Code"
  def puts(_), do: :ok
  def binwrite(_, _), do: :ok
end

Application.put_env(:yahoo_fantasy_ex, :io, FakeIO)
Application.put_env(:yahoo_fantasy_ex, :http_client, HTTPoison.BaseMock)
Application.put_env(:yahoo_fantasy_ex, :token_manager, YahooFantasyEx.Tokens.ManagerMock)
