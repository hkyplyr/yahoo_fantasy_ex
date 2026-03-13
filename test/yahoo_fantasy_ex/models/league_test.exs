defmodule YahooFantasyEx.Models.LeagueTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.League

  describe "new/1" do
    test "parses league metadata correctly" do
      data = load_fixture("league/metadata.json")

      assert %{
               current_week: 17,
               draft_status: :postdraft,
               edit_key: "17",
               end_date: ~D[2024-01-01],
               end_week: 17,
               felo_tier: :silver,
               game_code: :nfl,
               is_cash_league: false,
               is_pro_league: false,
               league_id: 12_345,
               league_key: "nfl.l.12345",
               league_type: :private,
               league_update_timestamp: 1_704_959_183,
               logo_url: "https://yahoo.com/logo_url",
               name: "Fantasy Football League",
               num_teams: 12,
               renew: "nfl.l.54321",
               renewed: nil,
               scoring_type: :head,
               season: 2023,
               short_invitation_url:
                 "https://football.fantasysports.yahoo.com/2023/f1/12345/invitation",
               start_date: ~D[2023-09-07],
               start_week: 1,
               url: "https://football.fantasysports.yahoo.com/2023/f1/12345",
               weekly_deadline: nil,
               draft_results: [],
               players: [],
               teams: []
             } = League.new(data[:fantasy_content][:league])
    end

    test "parses teams correctly" do
      data = load_fixture("league/teams.json")

      assert %{
               name: "Fantasy Football League",
               draft_results: [],
               players: [],
               teams: [
                 %{
                   clinched_playoffs: true,
                   faab_balance: 56,
                   has_draft_grade: true,
                   league_scoring_type: :head,
                   name: "Bed Bath & Bijan",
                   number_of_moves: 28,
                   number_of_trades: 0,
                   team_id: 1,
                   team_key: "nfl.l.12345.t.1",
                   team_live_projected_points: nil,
                   team_logos: "https://yahoo.com/logo_url",
                   team_points: nil,
                   team_projected_points: nil,
                   team_stats: nil,
                   url: "https://football.fantasysports.yahoo.com/2023/f1/12345/1",
                   waiver_priority: 2,
                   managers: [
                     %{
                       nickname: "Team One",
                       manager_id: 1,
                       image_url: "https://yahoo.com/image_url",
                       guid: "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
                       felo_score: 779,
                       felo_tier: :gold
                     }
                   ]
                 },
                 %{
                   clinched_playoffs: true,
                   faab_balance: 100,
                   has_draft_grade: true,
                   league_scoring_type: :head,
                   name: "Boats and Younghoes",
                   number_of_moves: 8,
                   number_of_trades: 0,
                   team_id: 2,
                   team_key: "nfl.l.12345.t.2",
                   team_live_projected_points: nil,
                   team_logos: "https://yahoo.com/logo_url",
                   team_points: nil,
                   team_projected_points: nil,
                   team_stats: nil,
                   url: "https://football.fantasysports.yahoo.com/2023/f1/12345/2",
                   waiver_priority: 8,
                   managers: [
                     %{
                       nickname: "Team Two",
                       manager_id: 2,
                       image_url: "https://yahoo.com/image_url",
                       guid: "ZYXWUTSRQPONMLKJIHGFEDCBA",
                       felo_score: 596,
                       felo_tier: :bronze
                     }
                   ]
                 }
               ]
             } = League.new(data[:fantasy_content][:league])
    end
  end
end
