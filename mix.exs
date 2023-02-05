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
      test_coverage: [ignore_modules: [YahooFantasyEx, YahooFantasyEx.ModelCase]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:credo, "~> 1.6.7", only: :dev},
      {:dialyxir, "~> 1.2.0", only: [:dev, :test]},
      {:exconstructor, "~>1.2.8"},
      {:httpoison, "~> 2.0.0"},
      {:jason, "~> 1.3"},
      {:mox, "~> 1.0.2", only: :test},
      {:poison, "~> 5.0.0"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
