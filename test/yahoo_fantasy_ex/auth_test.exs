defmodule YahooFantasyEx.AuthTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Auth

  setup [:setup_bypass, :setup_tokens]

  describe "get_access_token/0" do
    @tag token_state: :no_token
    test "retrieves access token from server when there is no existing token", ctx do
      Bypass.stub(ctx.authorize_bypass, "GET", "/", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("Location", "location")
        |> Plug.Conn.send_resp(200, "")
      end)

      Bypass.stub(ctx.token_bypass, "POST", "/", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.send_resp(200, tokens(:new))
      end)

      assert "new_token" == Auth.get_access_token()
    end

    @tag token_state: :expired
    test "retreives refreshed access token when existing tokens are expired", ctx do
      Bypass.stub(ctx.authorize_bypass, "GET", "/", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("Location", "location")
        |> Plug.Conn.send_resp(200, "")
      end)

      Bypass.stub(ctx.token_bypass, "POST", "/", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.send_resp(200, tokens(:refreshed))
      end)

      assert "refreshed_token" == Auth.get_access_token()
    end

    @tag token_state: :valid
    test "returns existing access token" do
      assert "access_token" == Auth.get_access_token()
    end
  end
end
