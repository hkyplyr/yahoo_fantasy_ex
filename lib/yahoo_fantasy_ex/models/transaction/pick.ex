defmodule YahooFantasyEx.Models.Transaction.Pick do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :destination_team_key,
    :destination_team_name,
    :original_team_key,
    :original_team_name,
    :round,
    :source_team_key,
    :source_team_name
  ]

  @type t :: %__MODULE__{
          destination_team_key: String.t(),
          destination_team_name: String.t(),
          original_team_key: String.t(),
          original_team_name: String.t(),
          round: integer() | nil,
          source_team_key: String.t(),
          source_team_name: String.t()
        }

  @spec new(map()) :: t()
  def new(%{"pick" => data}) do
    data
    |> super()
    |> transform(round: &cast_integer/1)
  end
end
