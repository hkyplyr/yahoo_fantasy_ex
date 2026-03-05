defmodule YahooFantasyEx.Migrations.SQLite do
  @moduledoc false

  use Ecto.Migration

  def up do
    create_if_not_exists table(:yahoo_tokens, primary_key: false) do
      add(:id, :string, primary_key: true)
      add(:access_token, :string)
      add(:refresh_token, :string)
      add(:expires_by, :utc_datetime)
    end
  end

  def down do
    drop_if_exists(table(:yahoo_tokens))
  end
end
