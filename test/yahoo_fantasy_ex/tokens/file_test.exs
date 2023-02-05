defmodule YahooFantasyEx.Tokens.FileTest do
  use ExUnit.Case
  doctest YahooFantasyEx.Tokens.File

  alias YahooFantasyEx.Tokens.File, as: FileManager

  @tag :ci_only
  describe "read/0 and write/1" do
    test "can write and read the token file" do
      :ok = FileManager.write("test")

      assert {:ok, "\"test\""} == FileManager.read()
    end
  end
end
