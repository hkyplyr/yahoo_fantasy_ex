defmodule YahooFantasyEx.Models.MatchupTest do
  use YahooFantasyEx.BaseCase

  # alias YahooFantasyEx.Models.Matchup
  # alias YahooFantasyEx.Models.Matchup.StatWinner

  # describe "new/1" do
  #   test "returns the list of matchups with valid data" do
  #     json = load_fixture("league/scoreboard.json")
  #
  #     assert [
  #              %Matchup{
  #                week: 1,
  #                week_start: "2022-10-07",
  #                week_end: "2022-10-16",
  #                status: :postevent,
  #                is_consolation: false,
  #                is_playoffs: false,
  #                is_tied: false,
  #                winner_team_key: "nhl.l.12345.t.5",
  #                stat_winners: [
  #                  %StatWinner{
  #                    stat_id: 1,
  #                    winner_team_key: "nhl.l.12345.t.5"
  #                  },
  #                  %StatWinner{
  #                    stat_id: 11,
  #                    is_tied: true
  #                  }
  #                ]
  #              },
  #              %Matchup{}
  #            ] = Enum.map(json, &Matchup.new/1)
  #   end
  # end
end
