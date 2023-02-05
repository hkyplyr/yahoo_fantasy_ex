defmodule YahooFantasyEx.Models.League.DraftResult do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :pick,
    :player,
    :player_key,
    :round,
    :team_key
  ]

  @type t :: %__MODULE__{
          pick: integer() | nil,
          player: Player.t(),
          player_key: String.t(),
          round: integer() | nil,
          team_key: String.t()
        }

  @spec new(tuple()) :: t()
  def new({_, %{"draft_result" => data}}) do
    data
    |> super()
    |> transform(
      pick: &cast_integer/1,
      round: &cast_integer/1
    )
    |> then(&%{&1 | player: parse_player(data)})
  end

  defp parse_player(%{"0" => %{"players" => %{"0" => player}}}) do
    Player.new({"0", player})
  end

  defp parse_player(_), do: nil
end
