defmodule YahooFantasyEx.Api.Parser do
  @moduledoc false

  alias YahooFantasyEx.Models.League
  alias YahooFantasyEx.Models.League.DraftResult
  alias YahooFantasyEx.Models.League.Settings
  alias YahooFantasyEx.Models.Player
  alias YahooFantasyEx.Models.Team
  alias YahooFantasyEx.Models.Transaction

  @spec parse(map()) :: League.t()
  def parse(%{"fantasy_content" => fantasy_content}), do: do_parse(fantasy_content)

  defp do_parse(%{"league" => league}) do
    League.new(league)
  end

  @type subresource ::
          Settings.t()
          | [DraftResult.t()]
          | [Player.t()]
          | [Team.t()]
          | [Transaction.t()]

  @spec parse_subresource(%{String.t() => map()}) :: {atom(), subresource()}
  def parse_subresource(%{"teams" => teams}) do
    {:teams, parse_valid_entities(teams, &Team.new/1)}
  end

  def parse_subresource(%{"settings" => settings}) do
    {:settings, Settings.new(settings)}
  end

  def parse_subresource(%{"draft_results" => draft_results}) do
    {:draft_results, parse_valid_entities(draft_results, &DraftResult.new/1)}
  end

  def parse_subresource(%{"players" => players}) do
    {:players, parse_valid_entities(players, &Player.new/1)}
  end

  def parse_subresource(%{"transactions" => transactions}) do
    {:transactions, parse_valid_entities(transactions, &Transaction.new/1)}
  end

  defp parse_valid_entities(entities, constructor) do
    entities
    |> Enum.reject(&(elem(&1, 0) == "count"))
    |> Enum.map(&constructor.(&1))
  end
end
