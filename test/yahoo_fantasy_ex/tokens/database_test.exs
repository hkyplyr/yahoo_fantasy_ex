defmodule YahooFantasyEx.Tokens.DatabaseTest do
  use ExUnit.Case

  alias YahooFantasyEx.Test.SQLiteRepo
  alias YahooFantasyEx.Token
  alias YahooFantasyEx.Tokens

  @valid_params %{
    access_token: "access_token",
    refresh_token: "refresh_token",
    expires_by: DateTime.utc_now(:second)
  }

  setup do
    Application.put_env(:yahoo_fantasy_ex, :repo, SQLiteRepo)
    on_exit(fn -> SQLiteRepo.delete_all(Token) end)
  end

  describe "get/0" do
    test "can get the token data from the database" do
      SQLiteRepo.insert(Token.changeset(@valid_params))

      assert {:ok, @valid_params} = Tokens.Database.get()
    end

    test "returns error when token is not found" do
      assert :error == Tokens.Database.get()
    end
  end

  describe "put/1" do
    test "can write token data to database" do
      assert :error = Tokens.Database.get()
      assert :ok = Tokens.Database.put(@valid_params)
      assert {:ok, @valid_params} = Tokens.Database.get()
    end

    test "can update token data if one exists" do
      assert :ok = Tokens.Database.put(@valid_params)

      updated_params = Map.put(@valid_params, :access_token, "new_access_token")
      assert :ok = Tokens.Database.put(updated_params)
      assert %Token{access_token: "new_access_token"} = SQLiteRepo.one(Token)
    end

    test "returns error for invalid params" do
      assert :error = Tokens.Database.put(%{})
    end
  end
end
