defmodule YahooFantasyEx.Models.League do
  @moduledoc false
  use YahooFantasyEx, :model

  alias YahooFantasyEx.Api.Parser

  defstruct [
    :allow_add_to_dl_extra_pos,
    :current_week,
    :draft_status,
    :edit_key,
    :end_date,
    :end_week,
    :felo_tier,
    :game_code,
    :iris_group_chat_id,
    :is_cash_league,
    :is_pro_league,
    :league_id,
    :league_key,
    :league_type,
    :league_update_timestamp,
    :logo_url,
    :name,
    :num_teams,
    :password,
    :renew,
    :renewed,
    :scoring_type,
    :season,
    :short_invitation_url,
    :start_date,
    :start_week,
    :url,
    :weekly_deadline,
    :settings,
    draft_results: [],
    players: [],
    teams: [],
    transactions: [],
    scoreboard: []
  ]

  @type t :: %__MODULE__{
          allow_add_to_dl_extra_pos: boolean(),
          current_week: integer(),
          draft_status: atom(),
          edit_key: String.t(),
          end_date: String.t(),
          end_week: integer(),
          felo_tier: atom(),
          game_code: String.t(),
          iris_group_chat_id: String.t(),
          is_cash_league: boolean(),
          is_pro_league: boolean(),
          league_id: integer(),
          league_key: String.t(),
          league_type: atom(),
          league_update_timestamp: integer(),
          logo_url: String.t() | nil,
          name: String.t(),
          num_teams: integer(),
          password: String.t(),
          renew: String.t(),
          renewed: String.t() | nil,
          scoring_type: atom(),
          season: integer(),
          short_invitation_url: String.t(),
          start_date: String.t(),
          start_week: integer(),
          url: String.t(),
          weekly_deadline: atom(),
          settings: Settings.t(),
          draft_results: [DraftResult.t()],
          players: [Player.t()],
          teams: [Team.t()],
          transactions: [Transaction.t()]
        }

  @spec new(nonempty_maybe_improper_list) :: t()
  def new([league_info | subresources]) do
    league_info
    |> super()
    |> transform(
      allow_add_to_dl_extra_pos: &cast_boolean/1,
      current_week: &cast_integer/1,
      draft_status: &cast_atom!/1,
      end_week: &cast_integer/1,
      felo_tier: &cast_atom!/1,
      is_cash_league: &cast_boolean/1,
      is_pro_league: &cast_boolean/1,
      league_id: &cast_integer/1,
      league_type: &cast_atom!/1,
      league_update_timestamp: &cast_integer/1,
      logo_url: &parse_logo_url/1,
      num_teams: &cast_integer/1,
      renew: &parse_renew_key/1,
      renewed: &parse_renew_key/1,
      scoring_type: &cast_atom!/1,
      season: &cast_integer/1,
      start_week: &cast_integer/1,
      weekly_deadline: &cast_atom!/1
    )
    |> populate_subresources(subresources)
  end

  defp populate_subresources(league, subresources) do
    Enum.reduce(subresources, league, fn subresource, acc ->
      {key, parsed} = Parser.parse_subresource(subresource)
      Map.put(acc, key, parsed)
    end)
  end

  defp parse_renew_key(""), do: nil

  defp parse_renew_key(renew_key) do
    String.replace(renew_key, "_", ".l.")
  end

  defp parse_logo_url(false), do: nil
  defp parse_logo_url(value), do: value
end
