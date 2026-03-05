defmodule YahooFantasyEx.TokensTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Test.SQLiteRepo
  alias YahooFantasyEx.Token
  alias YahooFantasyEx.Tokens

  @valid_params %{
    access_token: "access_token",
    refresh_token: "refresh_token",
    expires_by: DateTime.utc_now(:second)
  }

  describe "uses the database module" do
    setup do
      Application.put_env(:yahoo_fantasy_ex, :token_module, Tokens.Database)
      Application.put_env(:yahoo_fantasy_ex, :repo, SQLiteRepo)
      on_exit(fn -> SQLiteRepo.delete_all(Token) end)
    end

    test "can put and get token data from the db" do
      assert :error = Tokens.get()
      assert :ok = Tokens.put(@valid_params)
      assert {:ok, @valid_params} = Tokens.get()
    end
  end

  describe "uses the file module" do
    setup do
      token_file = Path.join(System.tmp_dir!(), "tokens.json")
      Application.put_env(:yahoo_fantasy_ex, :token_module, Tokens.File)
      Application.put_env(:yahoo_fantasy_ex, :token_file, token_file)
      on_exit(fn -> File.rm(token_file) end)
    end

    test "can put and get token data from the db" do
      assert :error = Tokens.get()
      assert :ok = Tokens.put(@valid_params)
      assert {:ok, @valid_params} = Tokens.get()
    end
  end
end
