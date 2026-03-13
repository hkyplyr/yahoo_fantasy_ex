defmodule YahooFantasyEx.Migrations.SQLiteTest do
  use YahooFantasyEx.BaseCase

  defmodule MigrationRepo do
    @moduledoc false
    use Ecto.Repo, otp_app: :yahoo_fantasy_ex, adapter: Ecto.Adapters.SQLite3

    alias YahooFantasyEx.Test.SQLiteRepo

    def init(_, _) do
      {:ok, Keyword.put(SQLiteRepo.config(), :database, "priv/migration.db")}
    end
  end

  defmodule Migration do
    use Ecto.Migration

    alias YahooFantasyEx.Migrations.SQLite

    def up, do: SQLite.up()
    def down, do: SQLite.down()
  end

  test "migrating a sqlite database" do
    start_supervised!(MigrationRepo)

    MigrationRepo.__adapter__().storage_up(MigrationRepo.config())

    assert :ok = Ecto.Migrator.up(MigrationRepo, 1, Migration)
    assert table_exists?()

    assert :ok = Ecto.Migrator.down(MigrationRepo, 1, Migration)
    refute table_exists?()
  end

  defp table_exists? do
    query =
      "SELECT EXISTS (SELECT 1 FROM sqlite_master WHERE type = 'table' AND name = 'yahoo_tokens')"

    {:ok, %{rows: [[exists]]}} = MigrationRepo.query(query)

    exists != 0
  end
end
