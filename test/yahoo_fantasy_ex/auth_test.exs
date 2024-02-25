defmodule YahooFantasyEx.AuthTest do
  use ExUnit.Case

  import Mox

  alias YahooFantasyEx.Auth
  alias YahooFantasyEx.Tokens.ManagerMock

  setup :verify_on_exit!

  setup do
    [
      authorize_bypass: Bypass.open(port: 7998),
      token_bypass: Bypass.open(port: 7999)
    ]
  end

  describe "get_access_token/0" do
    doctest YahooFantasyEx.Auth, only: [get_access_token: 0]

    setup ctx do
      expected_read_value =
        case Map.get(ctx, :expected_state, :existing) do
          :error -> {:error, :enoent}
          token_state -> {:ok, tokens(token_state)}
        end

      expect(ManagerMock, :read, fn -> expected_read_value end)

      :ok
    end

    @tag expected_state: :error
    test "retrieves access token from server when one does not exist", ctx do
      Bypass.stub(ctx.authorize_bypass, "GET", "/", fn conn ->
        conn = Plug.Conn.put_resp_header(conn, "Location", "location")
        Plug.Conn.send_resp(conn, 200, "")
      end)

      Bypass.stub(ctx.token_bypass, "POST", "/", fn conn ->
        Plug.Conn.send_resp(conn, 200, tokens(:new))
      end)

      expect(ManagerMock, :write, fn _ -> :ok end)

      assert "new_token" == Auth.get_access_token()
    end

    @tag expected_state: :expired
    test "returns a refreshed access token when existing tokens are expired", ctx do
      expect(ManagerMock, :write, fn _ -> :ok end)

      Bypass.stub(ctx.authorize_bypass, "GET", "/", fn conn ->
        conn = Plug.Conn.put_resp_header(conn, "Location", "location")
        Plug.Conn.send_resp(conn, 200, "")
      end)

      Bypass.stub(ctx.token_bypass, "POST", "/", fn conn ->
        Plug.Conn.send_resp(conn, 200, tokens(:refreshed))
      end)

      assert "refreshed_token" == Auth.get_access_token()
    end

    @tag expected_state: :existing
    test "returns existing access token" do
      assert "access_token" == Auth.get_access_token()
    end
  end

  defp tokens(:new) do
    build_tokens(%{"access_token" => "new_token"})
  end

  defp tokens(:expired) do
    build_tokens(%{"expires_by" => 0})
  end

  defp tokens(:existing) do
    expires_by =
      DateTime.utc_now()
      |> DateTime.to_unix()
      |> Kernel.+(500)

    build_tokens(%{"expires_by" => expires_by})
  end

  defp tokens(:refreshed) do
    build_tokens(%{"access_token" => "refreshed_token"})
  end

  defp build_tokens(attrs) do
    %{
      "access_token" => "access_token",
      "refresh_token" => "refresh_token",
      "expires_in" => 3600
    }
    |> Map.merge(attrs)
    |> Jason.encode!()
  end
end
