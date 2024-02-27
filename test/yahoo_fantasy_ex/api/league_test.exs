defmodule YahooFantasyEx.Api.LeagueTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Api.League

  setup [:setup_bypass, :setup_tokens]

  @league_key "nhl.l.12345"

  describe "info/1" do
    test "sends correct request for the metadata ednpoint", ctx do
      set_response(ctx, "metadata")

      assert %{league_key: "nhl.l.12345"} = League.info(@league_key)
    end
  end

  describe "teams/1" do
    test "sends correct request for the teams endpoint", ctx do
      set_response(ctx, "teams", "/stats")

      assert %{
               league_key: "nhl.l.12345",
               teams: [
                 %{team_key: "nhl.l.12345.t.1"},
                 %{team_key: "nhl.l.12345.t.2"}
               ]
             } = League.teams(@league_key)
    end
  end

  describe "players/2" do
    test "sends correct request for the players endpoint", ctx do
      set_response(ctx, "players", ";start=0;count=25/stats")

      assert %{
               players: [
                 %{player_key: "nhl.p.1600"},
                 %{player_key: "nhl.p.1700"}
               ]
             } = League.players(@league_key)
    end
  end

  describe "settings/1" do
    test "sends correct request for the settings endpoint", ctx do
      set_response(ctx, "settings")

      assert %{} = League.settings(@league_key)
    end
  end

  describe "transactions/1" do
    test "sends correct request for the transactions endpoint", ctx do
      set_response(ctx, "transactions")

      assert %{} = League.transactions(@league_key)
    end
  end

  describe "draft_results/2" do
    test "sends correct request for the draftresults endpoint", ctx do
      set_response(ctx, "draftresults")

      assert %{} = League.draft_results(@league_key)
    end
  end

  describe "scoreboard/2" do
    test "sends correct request for the scoreboard endpoint", ctx do
      set_response(ctx, "scoreboard")

      assert %{} = League.scoreboard(@league_key)
    end

    test "sends correct request for the scoreboard endpoint with week param", ctx do
      set_response(ctx, "scoreboard", ";week=1,2,3")

      assert %{} = League.scoreboard(@league_key, weeks: [1, 2, 3])
    end
  end

  defp set_response(ctx, resource, params \\ "") do
    path = "/league/nhl.l.12345/" <> resource <> params
    response_body = load_json("league/#{resource}.json")

    Bypass.expect(ctx.base_bypass, "GET", path, fn conn ->
      conn
      |> Plug.Conn.put_resp_content_type("application/json")
      |> Plug.Conn.send_resp(200, response_body)
    end)
  end
end
