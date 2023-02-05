defmodule YahooFantasyEx.Api.League do
  @moduledoc false

  alias YahooFantasyEx.Api.Client
  alias YahooFantasyEx.Api.Parser
  alias YahooFantasyEx.Models.League

  @spec info(String.t()) :: League.t()
  def info(league_key) do
    get("/league/#{league_key}/metadata")
  end

  @spec teams(String.t()) :: League.t()
  def teams(league_key) do
    get("/league/#{league_key}/teams/stats")
  end

  @spec players(String.t(), Keyword.t()) :: League.t()
  def players(league_key, opts \\ []) do
    start = Keyword.get(opts, :start, 0)
    count = Keyword.get(opts, :count, 25)

    get("/league/#{league_key}/players/stats;start=#{start};count=#{count}")
  end

  @spec settings(String.t()) :: League.t()
  def settings(league_key) do
    get("/league/#{league_key}/settings")
  end

  @spec transactions(String.t()) :: League.t()
  def transactions(league_key) do
    get("/league/#{league_key}/transactions")
  end

  @spec draft_results(String.t(), Keyword.t()) :: League.t()
  def draft_results(league_key, opts \\ []) do
    include_players? = Keyword.get(opts, :include_players?, false)

    url = "/league/#{league_key}/draftresults"

    if include_players?, do: get("#{url}/players"), else: get(url)
  end

  defp get(url) do
    url |> Client.get!() |> Parser.parse()
  end
end
