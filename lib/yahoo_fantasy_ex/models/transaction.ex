defmodule YahooFantasyEx.Models.Transaction do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :status,
    :type,
    :timestamp,
    :tradee_team_key,
    :trader_team_key,
    :transaction_key,
    players: [],
    picks: []
  ]

  @type t :: %__MODULE__{
          status: atom(),
          type: atom(),
          timestamp: integer(),
          tradee_team_key: String.t(),
          trader_team_key: String.t(),
          transaction_key: String.t(),
          players: [Player.t()],
          picks: [Pick.t()]
        }

  @spec new(map()) :: t() | nil
  def new({_, %{"transaction" => data}}) do
    data
    |> flatten_attributes()
    |> super()
    |> transform(
      picks: &parse_picks/1,
      players: &parse_players/1,
      status: &cast_atom!/1,
      type: &parse_type/1,
      timestamp: &cast_integer/1
    )
  end

  def new(_), do: nil

  defp parse_type("add/drop"), do: :add_drop
  defp parse_type(value), do: cast_atom!(value)

  defp parse_players(players) do
    players
    |> Enum.map(&Player.new/1)
    |> Enum.reject(&is_nil/1)
  end

  defp parse_picks(picks) do
    Enum.map(picks, &Pick.new/1)
  end
end
