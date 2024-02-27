defmodule YahooFantasyEx.Models.League do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      allow_add_to_dl_extra_pos: :boolean,
      current_week: :integer,
      draft_status: :atom,
      edit_key: :string,
      end_date: :date,
      end_week: :integer,
      felo_tier: :atom,
      game_code: :atom,
      is_cash_league: :boolean,
      is_pro_league: :boolean,
      league_id: :integer,
      league_key: :string,
      league_type: :atom,
      league_update_timestamp: :integer,
      logo_url: &League.logo_url/1,
      name: :string,
      num_teams: :integer,
      renew: &League.renew_key/1,
      renewed: &League.renew_key/1,
      scoring_type: :atom,
      season: :integer,
      short_invitation_url: :string,
      start_date: :date,
      start_week: :integer,
      url: :string,
      weekly_deadline: :atom,
      draft_results: {:many, YahooFantasyEx.Models.League.DraftResult},
      players: {:many, YahooFantasyEx.Models.Player},
      teams: {:many, YahooFantasyEx.Models.Team}
    ]

  @spec logo_url(String.t() | boolean()) :: String.t() | nil
  def logo_url(false), do: nil
  def logo_url(logo_url), do: logo_url

  @spec renew_key(String.t()) :: String.t() | nil
  def renew_key(""), do: nil
  def renew_key(renew_key), do: String.replace(renew_key, "_", ".l.")
end
