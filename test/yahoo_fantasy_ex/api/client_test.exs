defmodule YahooFantasyEx.Api.ClientTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Api.Client

  setup [:setup_bypass, :setup_tokens]

  describe "get!/1" do
    test "gets and decodes the response from the configured url", ctx do
      Bypass.expect(ctx.base_bypass, "GET", "/test", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.send_resp(200, "{\"test\": \"response\"}")
      end)

      assert %{test: "response"} = Client.get!("/test")
    end
  end
end
