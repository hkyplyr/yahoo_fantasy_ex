defmodule YahooFantasyEx.Api.LeagueTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Api.League

  import Mox

  alias HTTPoison.Response, as: HttpResponse

  alias YahooFantasyEx.Api.League
  alias YahooFantasyEx.Models.League, as: LeagueModel
  alias YahooFantasyEx.Tokens.ManagerMock

  setup :verify_on_exit!

  setup :expect_tokens

  @league_key "nhl.l.12345"

  describe "info/1" do
    test "sends correct request for the metadata ednpoint" do
      expect(HTTPoison.BaseMock, :get!, fn url, _, _ ->
        assert String.contains?(url, @league_key)
        assert String.contains?(url, "/metadata")

        %HttpResponse{body: response_body()}
      end)

      assert %LeagueModel{} = League.info(@league_key)
    end
  end

  describe "teams/1" do
    test "sends correct request for the teams endpoint" do
      expect(HTTPoison.BaseMock, :get!, fn url, _, _ ->
        assert String.contains?(url, @league_key)
        assert String.contains?(url, "/teams/stats")

        %HttpResponse{body: response_body()}
      end)

      assert %LeagueModel{} = League.teams(@league_key)
    end
  end

  describe "players/2" do
    test "sends correct request for the players endpoint" do
      expect(HTTPoison.BaseMock, :get!, fn url, _, _ ->
        assert String.contains?(url, @league_key)
        assert String.contains?(url, "/players/stats;start=0;count=25")

        %HttpResponse{body: response_body()}
      end)

      assert %LeagueModel{} = League.players(@league_key)
    end
  end

  describe "settings/1" do
    test "sends correct request for the settings endpoint" do
      expect(HTTPoison.BaseMock, :get!, fn url, _, _ ->
        assert String.contains?(url, @league_key)
        assert String.contains?(url, "/settings")

        %HttpResponse{body: response_body()}
      end)

      assert %LeagueModel{} = League.settings(@league_key)
    end
  end

  describe "transactions/1" do
    test "sends correct request for the transactions endpoint" do
      expect(HTTPoison.BaseMock, :get!, fn url, _, _ ->
        assert String.contains?(url, @league_key)
        assert String.contains?(url, "/transactions")

        %HttpResponse{body: response_body()}
      end)

      assert %LeagueModel{} = League.transactions(@league_key)
    end
  end

  describe "draft_results/2" do
    test "sends correct request for the draftresults endpoint" do
      expect(HTTPoison.BaseMock, :get!, fn url, _, _ ->
        assert String.contains?(url, @league_key)
        assert String.contains?(url, "/draftresults")

        %HttpResponse{body: response_body()}
      end)

      assert %LeagueModel{} = League.draft_results(@league_key)
    end
  end

  describe "scoreboard/2" do
    test "sends correct request for the scoreboard endpoint" do
      expect(HTTPoison.BaseMock, :get!, fn url, _, _ ->
        assert String.contains?(url, @league_key)
        assert String.contains?(url, "/scoreboard")

        %HttpResponse{body: response_body()}
      end)

      assert %LeagueModel{} = League.scoreboard(@league_key)
    end

    test "sends correct request for the scoreboard endpoint with week param" do
      expect(HTTPoison.BaseMock, :get!, fn url, _, _ ->
        assert String.contains?(url, @league_key)
        assert String.contains?(url, "/scoreboard;week=1,2,3")

        %HttpResponse{body: response_body()}
      end)

      assert %LeagueModel{} = League.scoreboard(@league_key, weeks: [1, 2, 3])
    end
  end

  defp response_body do
    Jason.encode!(%{"fantasy_content" => %{"league" => load_fixture("league/metadata.json")}})
  end

  defp expect_tokens(_) do
    expires_by =
      DateTime.utc_now()
      |> DateTime.to_unix()
      |> Kernel.+(500)

    tokens = %{
      "access_token" => "access_token",
      "refresh_token" => "refresh_token",
      "expires_in" => 3600,
      "expires_by" => expires_by
    }

    expect(ManagerMock, :read, fn -> {:ok, Jason.encode!(tokens)} end)

    :ok
  end
end
