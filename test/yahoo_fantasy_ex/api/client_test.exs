defmodule YahooFantasyEx.Api.ClientTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Api.Client

  import Mox

  alias HTTPoison.Response, as: HttpResponse

  alias YahooFantasyEx.Api.Client
  alias YahooFantasyEx.Tokens.ManagerMock

  setup :verify_on_exit!

  describe "get!/1" do
    test "test" do
      body = %{"fantasy_content" => %{"league" => load_fixture("league/metadata.json")}}

      expires_by =
        DateTime.utc_now()
        |> DateTime.to_unix()
        |> Kernel.+(500)

      tokens = %{
        "access_token" => "access_token",
        "refresh_token" => "refresh_token",
        "expires_in" => 3600,
        "expires_by" => expires_by
      }

      expect(ManagerMock, :read, fn -> {:ok, Jason.encode!(tokens)} end)

      expect(HTTPoison.BaseMock, :get!, fn _, _, _ -> %HttpResponse{body: Jason.encode!(body)} end)

      assert %{
               "fantasy_content" => %{
                 "league" => [
                   %{"league_id" => "6738"},
                   %{"players" => %{}}
                 ]
               }
             } = Client.get!("/path")
    end
  end
end
