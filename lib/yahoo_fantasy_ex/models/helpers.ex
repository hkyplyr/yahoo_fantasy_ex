defmodule YahooFantasyEx.Models.Helpers do
  @moduledoc false

  @spec flatten_attributes(list()) :: map()
  def flatten_attributes(attributes) do
    attributes
    |> List.flatten()
    |> Enum.reduce(fn x, y ->
      Map.merge(x, y, fn _k, v1, v2 -> v2 ++ v1 end)
    end)
  end

  @spec cast_boolean(term()) :: boolean()
  def cast_boolean("0"), do: false
  def cast_boolean("1"), do: true
  def cast_boolean(0), do: false
  def cast_boolean(1), do: true
  def cast_boolean(nil), do: false
  def cast_boolean(true), do: true
  def cast_boolean(false), do: false

  @spec cast_integer(term()) :: integer() | nil
  def cast_integer("-"), do: nil
  def cast_integer(""), do: nil
  def cast_integer(value) when is_binary(value), do: String.to_integer(value)
  def cast_integer(value) when is_number(value), do: value
  def cast_integer(nil), do: nil

  @spec cast_float(term()) :: float() | nil
  def cast_float("-"), do: nil

  def cast_float(value) when is_binary(value) do
    {float_value, ""} = Float.parse(value)
    float_value
  end

  def cast_float(value), do: value

  @spec cast_atom(String.t()) :: atom()
  def cast_atom(value), do: String.to_existing_atom(value)

  @spec cast_atom!(String.t()) :: atom()
  def cast_atom!(value), do: String.to_atom(value)

  @spec translate_sort_order(String.t()) :: :asc | :desc
  def translate_sort_order("1"), do: :desc
  def translate_sort_order("0"), do: :asc

  @spec translate_status(term()) :: term()
  def translate_status("NA"), do: :not_active
  def translate_status("IR-LT"), do: :long_term_injured_reserve
  def translate_status("IR"), do: :injured_reserve
  def translate_status("O"), do: :out
  def translate_status("DTD"), do: :day_to_day
  def translate_status("IR-NR"), do: :non_roster_injured_reserve
  def translate_status(_), do: :invalid

  @spec transform(struct(), Keyword.t()) :: struct()
  def transform(struct, transform_functions) do
    transform_functions
    |> Enum.reduce(struct, fn {field, transform_function}, acc ->
      transformed_value =
        struct
        |> Map.get(field)
        |> transform_function.()

      Map.put(acc, field, transformed_value)
    end)
  end
end
