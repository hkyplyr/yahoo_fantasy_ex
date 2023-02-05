defmodule YahooFantasyEx.Models.TeamTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Models.Team

  alias YahooFantasyEx.Models.Manager
  alias YahooFantasyEx.Models.Team

  describe "new/1" do
    test "returns settings for valid data" do
      json = load_fixture("league/teams.json")

      assert [
               %Team{
                 clinched_playoffs: false,
                 faab_balance: 100,
                 has_draft_grade: false,
                 league_scoring_type: :headpoint,
                 managers: [
                   %Manager{
                     email: "team_one_email@gmail.com",
                     felo_score: 867,
                     felo_tier: :platinum,
                     guid: "team_one_guid",
                     image_url: "team_one_logo.jpg",
                     manager_id: 1,
                     nickname: "Team One Nickname"
                   }
                 ],
                 name: "Team One",
                 number_of_moves: 28,
                 number_of_trades: 0,
                 team_id: 1,
                 team_key: "419.l.6738.t.1",
                 team_live_projected_points: nil,
                 team_logos: "team_one_logo.jpg",
                 team_projected_points: nil,
                 team_points: 3309.55,
                 team_remaining_games: nil,
                 url: "https://hockey.fantasysports.yahoo.com/hockey/6738/1",
                 waiver_priority: 2
               },
               %Team{}
             ] = Enum.map(json, &Team.new/1)
    end
  end
end
