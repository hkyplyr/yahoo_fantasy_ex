defmodule YahooFantasyEx.Token do
  @moduledoc """
  TODO - add moduledoc
  """
  use Ecto.Schema

  import Ecto.Changeset

  @required ~w(access_token refresh_token expires_by)a

  schema "yahoo_tokens" do
    field(:access_token, :string)
    field(:refresh_token, :string)
    field(:expires_by, :utc_datetime)
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, __schema__(:fields))
    |> validate_required(@required)
  end
end
