defmodule YahooFantasyEx.TokensTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Tokens

  setup :setup_tokens

  describe "read/0 and write/1" do
    @tag token_state: :no_token
    test "can write and read the token file" do
      :ok = Tokens.write("test")

      assert {:ok, "\"test\""} == Tokens.read()
    end
  end
end
