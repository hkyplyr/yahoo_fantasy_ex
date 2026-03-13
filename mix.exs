defmodule YahooFantasyEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :yahoo_fantasy_ex,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      test_coverage: [
        ignore_modules: [YahooFantasyEx.BaseCase, YahooFantasyEx.Test.SQLiteRepo],
        summary: [
          threshold: 50
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :ex_unit]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.10"},
      {:ecto_sqlite3, "~> 0.9", optional: true},
      {:jason, "~> 1.4"},
      {:req, "~> 0.4"},
      {:bypass, "~> 2.1", only: :test},
      {:credo, "~> 1.7.16", only: :dev},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
