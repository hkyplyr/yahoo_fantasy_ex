defmodule YahooFantasyEx.Api.Parser do
  @moduledoc false

  alias YahooFantasyEx.Models.League

  @spec parse(map()) :: League.t()
  def parse(%{fantasy_content: fantasy_content}), do: do_parse(fantasy_content)

  defp do_parse(%{league: league}) do
    League.new(league)
  end
end
