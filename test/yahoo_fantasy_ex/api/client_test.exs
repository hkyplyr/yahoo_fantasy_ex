defmodule YahooFantasyEx.Api.ClientTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Api.Client

  import Mox

  alias YahooFantasyEx.Api.Client
  alias YahooFantasyEx.Tokens.ManagerMock

  setup :verify_on_exit!

  setup do
    [bypass: Bypass.open(port: 7997)]
  end

  describe "get!/1" do
    test "test", ctx do
      Bypass.expect(ctx.bypass, "GET", "/path", fn conn ->
        body =
          Jason.encode!(%{
            "fantasy_content" => %{"league" => load_fixture("league/metadata.json")}
          })

        Plug.Conn.send_resp(conn, 200, body)
      end)

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
