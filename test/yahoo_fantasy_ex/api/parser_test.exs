defmodule YahooFantasyEx.Api.ParserTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Api.Parser

  alias YahooFantasyEx.Api.Parser
  alias YahooFantasyEx.Models.League
  alias YahooFantasyEx.Models.League.DraftResult
  alias YahooFantasyEx.Models.League.Settings
  alias YahooFantasyEx.Models.Player
  alias YahooFantasyEx.Models.Team
  alias YahooFantasyEx.Models.Transaction

  describe "parse/1" do
    test "sucessfully parses league data" do
      json = %{
        "fantasy_content" => %{
          "league" => load_fixture("league/metadata.json")
        }
      }

      assert %League{} = Parser.parse(json)
    end
  end

  describe "parse_subresource/1" do
    test "parse teams correctly" do
      json = %{"teams" => load_fixture("league/teams.json")}

      assert {:teams, [%Team{}, %Team{}]} = Parser.parse_subresource(json)
    end

    test "parse settings correctly" do
      json = %{"settings" => load_fixture("league/settings.json")}

      assert {:settings, %Settings{}} = Parser.parse_subresource(json)
    end

    test "parse players correctly" do
      json = %{"players" => load_fixture("league/players.json")}

      assert {:players, [%Player{}, %Player{}]} = Parser.parse_subresource(json)
    end

    test "parse transactions correctly" do
      json = %{"transactions" => load_fixture("league/transactions.json")}

      assert {:transactions, [%Transaction{}, %Transaction{}, %Transaction{}, %Transaction{}]} =
               Parser.parse_subresource(json)
    end

    test "parse draft results correctly" do
      json = %{"draft_results" => load_fixture("league/draftresults.json")}

      assert {:draft_results, [%DraftResult{}, %DraftResult{}]} = Parser.parse_subresource(json)
    end
  end
end
