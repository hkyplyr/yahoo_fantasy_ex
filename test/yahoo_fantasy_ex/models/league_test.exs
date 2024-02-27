defmodule YahooFantasyEx.Models.LeagueTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.League

  describe "new/1" do
    test "test" do
      json = load_fixture("league/metadata.json")

      assert %{
               current_week: 17,
               draft_status: :postdraft,
               edit_key: "2023-02-05",
               end_date: ~D[2023-04-02],
               end_week: 24,
               felo_tier: :gold,
               game_code: :nhl,
               is_cash_league: false,
               is_pro_league: false,
               league_id: 12_345,
               league_key: "nhl.l.12345",
               league_type: :private,
               league_update_timestamp: 1_675_587_096,
               logo_url: nil,
               name: "Keeper",
               num_teams: 12,
               renew: "411.l.4774",
               renewed: nil,
               scoring_type: :headpoint,
               season: 2022,
               short_invitation_url:
                 "https://hockey.fantasysports.yahoo.com/hockey/12345/invitation?key=9e0e5eaa89ae708b&ikey=dd80c7abe6645d51",
               start_date: ~D[2022-10-07],
               start_week: 1,
               url: "https://hockey.fantasysports.yahoo.com/hockey/12345",
               weekly_deadline: :intraday
             } = League.new(json[:fantasy_content][:league])
    end
  end
end
