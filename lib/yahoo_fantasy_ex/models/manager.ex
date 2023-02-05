defmodule YahooFantasyEx.Models.Manager do
  @moduledoc false
  use YahooFantasyEx, :model

  defstruct [
    :email,
    :felo_score,
    :felo_tier,
    :guid,
    :image_url,
    :manager_id,
    :nickname
  ]

  @type t :: %__MODULE__{
          email: String.t(),
          felo_score: integer() | nil,
          felo_tier: atom(),
          guid: String.t(),
          image_url: String.t(),
          manager_id: integer() | nil,
          nickname: String.t()
        }

  @spec new(map) :: t()
  def new(managers) when is_list(managers) do
    Enum.map(managers, &new/1)
  end

  def new(%{"manager" => data}) do
    data
    |> super()
    |> transform(
      felo_score: &cast_integer/1,
      felo_tier: &cast_atom!/1,
      manager_id: &cast_integer/1
    )
  end
end
