defmodule YahooFantasyEx.Tokens.FileTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Tokens

  @valid_params %{
    access_token: "access_token",
    refresh_token: "refresh_token",
    expires_by: DateTime.utc_now()
  }

  setup :mock_token_file

  describe "get/0" do
    @tag content: @valid_params
    test "can get the token data from the file" do
      assert {:ok, @valid_params} = Tokens.File.get()
    end

    test "returns error when token file not found" do
      assert :error = Tokens.File.get()
    end

    @tag content: %{}
    test "returns error when token file is invalid" do
      assert :error = Tokens.File.get()
    end
  end

  describe "put/1" do
    test "can write token data to file" do
      assert :error = Tokens.File.get()
      assert :ok = Tokens.File.put(@valid_params)
      assert {:ok, @valid_params} = Tokens.File.get()
    end
  end

  defp mock_token_file(ctx) do
    token_file = Path.join(System.tmp_dir!(), "tokens.json")
    Application.put_env(:yahoo_fantasy_ex, :token_file, token_file)
    on_exit(fn -> File.rm(token_file) end)

    case Map.get(ctx, :content) do
      nil -> :ok
      content -> File.write!(token_file, Jason.encode!(content))
    end
  end
end
