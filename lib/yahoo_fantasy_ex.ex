defmodule YahooFantasyEx do
  @moduledoc """
  Documentation for `YahooFantasyEx`.
  """

  def model do
    quote do
      use ExConstructor

      import YahooFantasyEx.Models.Helpers
      import YahooFantasyEx.Models.Types.Positions
      import YahooFantasyEx.Models.Types.PositionTypes

      alias YahooFantasyEx.Models.League
      alias YahooFantasyEx.Models.League.DraftResult
      alias YahooFantasyEx.Models.League.Settings
      alias YahooFantasyEx.Models.League.Settings.RosterPosition
      alias YahooFantasyEx.Models.League.Settings.StatCategory
      alias YahooFantasyEx.Models.League.Settings.StatModifier
      alias YahooFantasyEx.Models.Manager
      alias YahooFantasyEx.Models.Matchup
      alias YahooFantasyEx.Models.Matchup.StatWinner
      alias YahooFantasyEx.Models.Player
      alias YahooFantasyEx.Models.Player.Stat
      alias YahooFantasyEx.Models.Team
      alias YahooFantasyEx.Models.Transaction
      alias YahooFantasyEx.Models.Transaction.Pick
    end
  end

  defmacro __using__(type) do
    apply(__MODULE__, type, [])
  end
end
