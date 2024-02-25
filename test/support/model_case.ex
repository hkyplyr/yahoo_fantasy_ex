defmodule YahooFantasyEx.ModelCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  defmacro __using__(_) do
    quote do
      use ExUnit.Case

      import YahooFantasyEx.ModelCase
    end
  end

  def load_fixture(file_name) do
    "test/support/fixtures/#{file_name}"
    |> File.read!()
    |> Jason.decode!()
  end
end
