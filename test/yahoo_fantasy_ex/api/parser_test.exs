defmodule YahooFantasyEx.Api.ParserTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Api.Parser

  describe "parse/1" do
    test "sucessfully parses league data" do
      data = load_fixture("league/metadata.json")
      assert %{} = Parser.parse(data)
    end
  end
end
