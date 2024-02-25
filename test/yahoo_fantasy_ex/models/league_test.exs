defmodule YahooFantasyEx.Models.LeagueTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Models.League

  alias YahooFantasyEx.Models.League
  alias YahooFantasyEx.Models.Player

  describe "new/1" do
    test "test1" do
      [league_info | subresources] = load_fixture("league/metadata.json")
      league_info = Map.put(league_info, "logo_url", "logo_url")

      assert %League{logo_url: "logo_url"} = League.new([league_info | subresources])
    end

    test "test" do
      json = load_fixture("league/metadata.json")

      assert %League{
               allow_add_to_dl_extra_pos: true,
               current_week: 17,
               draft_status: :postdraft,
               edit_key: "2023-02-05",
               end_date: ~D[2023-04-02],
               end_week: 24,
               felo_tier: :gold,
               game_code: :nhl,
               is_cash_league: false,
               is_pro_league: false,
               league_id: 6738,
               league_key: "419.l.6738",
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
                 "https://hockey.fantasysports.yahoo.com/hockey/6738/invitation?key=9e0e5eaa89ae708b&ikey=dd80c7abe6645d51",
               start_date: ~D[2022-10-07],
               start_week: 1,
               url: "https://hockey.fantasysports.yahoo.com/hockey/6738",
               weekly_deadline: :intraday,
               settings: nil,
               draft_results: [],
               players: [%Player{}, %Player{}],
               teams: [],
               transactions: []
             } = League.new(json)
    end
  end
end
