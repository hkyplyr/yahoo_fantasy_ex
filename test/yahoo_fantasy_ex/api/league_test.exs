defmodule YahooFantasyEx.Api.LeagueTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Api.League

  import Mox

  alias YahooFantasyEx.Api.League
  alias YahooFantasyEx.Models.League, as: LeagueModel
  alias YahooFantasyEx.Tokens.ManagerMock

  setup [:verify_on_exit!, :setup_bypass, :expect_tokens]

  @league_key "nhl.l.12345"

  describe "info/1" do
    test "sends correct request for the metadata ednpoint", ctx do
      Bypass.expect(ctx.bypass, "GET", "/league/nhl.l.12345/metadata", fn conn ->
        Plug.Conn.send_resp(conn, 200, response_body())
      end)

      assert %LeagueModel{} = League.info(@league_key)
    end
  end

  describe "teams/1" do
    test "sends correct request for the teams endpoint", ctx do
      Bypass.expect(ctx.bypass, "GET", "/league/nhl.l.12345/teams/stats", fn conn ->
        Plug.Conn.send_resp(conn, 200, response_body())
      end)

      assert %LeagueModel{} = League.teams(@league_key)
    end
  end

  describe "players/2" do
    test "sends correct request for the players endpoint", ctx do
      Bypass.expect(
        ctx.bypass,
        "GET",
        "/league/nhl.l.12345/players;start=0;count=25/stats",
        fn conn ->
          Plug.Conn.send_resp(conn, 200, response_body())
        end
      )

      assert %LeagueModel{} = League.players(@league_key)
    end
  end

  describe "settings/1" do
    test "sends correct request for the settings endpoint", ctx do
      Bypass.expect(ctx.bypass, "GET", "/league/nhl.l.12345/settings", fn conn ->
        Plug.Conn.send_resp(conn, 200, response_body())
      end)

      assert %LeagueModel{} = League.settings(@league_key)
    end
  end

  describe "transactions/1" do
    test "sends correct request for the transactions endpoint", ctx do
      Bypass.expect(ctx.bypass, "GET", "/league/nhl.l.12345/transactions", fn conn ->
        Plug.Conn.send_resp(conn, 200, response_body())
      end)

      assert %LeagueModel{} = League.transactions(@league_key)
    end
  end

  describe "draft_results/2" do
    test "sends correct request for the draftresults endpoint", ctx do
      Bypass.expect(ctx.bypass, "GET", "/league/nhl.l.12345/draftresults", fn conn ->
        Plug.Conn.send_resp(conn, 200, response_body())
      end)

      assert %LeagueModel{} = League.draft_results(@league_key)
    end
  end

  describe "scoreboard/2" do
    test "sends correct request for the scoreboard endpoint", ctx do
      Bypass.expect(ctx.bypass, "GET", "/league/nhl.l.12345/scoreboard", fn conn ->
        Plug.Conn.send_resp(conn, 200, response_body())
      end)

      assert %LeagueModel{} = League.scoreboard(@league_key)
    end

    test "sends correct request for the scoreboard endpoint with week param", ctx do
      Bypass.expect(ctx.bypass, "GET", "/league/nhl.l.12345/scoreboard;week=1,2,3", fn conn ->
        Plug.Conn.send_resp(conn, 200, response_body())
      end)

      assert %LeagueModel{} = League.scoreboard(@league_key, weeks: [1, 2, 3])
    end
  end

  defp response_body do
    Jason.encode!(%{"fantasy_content" => %{"league" => load_fixture("league/metadata.json")}})
  end

  defp setup_bypass(_), do: [bypass: Bypass.open(port: 7997)]

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
