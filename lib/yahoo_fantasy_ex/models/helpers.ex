defmodule YahooFantasyEx.Models.Helpers do
  @moduledoc false

  @spec cast_string(term()) :: term()
  def cast_string(false), do: nil
  def cast_string(value), do: value

  @spec cast_boolean(term()) :: boolean()
  def cast_boolean(value) when is_binary(value), do: String.to_integer(value) == 1
  def cast_boolean(value) when is_integer(value), do: value == 1
  def cast_boolean(value) when is_boolean(value), do: value
  def cast_boolean(nil), do: false

  @nil_values ["-", "", nil]

  @spec cast_integer(term()) :: integer() | nil
  def cast_integer(value) when value in @nil_values, do: nil
  def cast_integer(value) when is_integer(value), do: value
  def cast_integer(value) when is_binary(value), do: String.to_integer(value)

  @spec cast_float(term()) :: float() | nil
  def cast_float(value) when value in @nil_values, do: nil
  def cast_float(value) when is_float(value), do: value
  def cast_float(value) when is_integer(value), do: value * 1.0
  def cast_float(<<".", _rest::binary>> = value), do: cast_float("0" <> value)

  def cast_float(value) when is_binary(value) do
    case Float.parse(value) do
      {float_value, _remainder} -> float_value
      _error -> nil
    end
  end

  @spec cast_atom(String.t()) :: atom()
  def cast_atom(value), do: String.to_existing_atom(value)

  @spec cast_atom!(String.t() | nil) :: atom() | nil
  def cast_atom!(value) when value in @nil_values, do: nil
  def cast_atom!(value), do: String.to_atom(value)

  @spec cast_date(term() | nil) :: Date.t() | nil
  def cast_date(nil), do: nil
  def cast_date(value), do: Date.from_iso8601!(value)

  @spec translate_sort_order(String.t()) :: :asc | :desc
  def translate_sort_order("1"), do: :desc
  def translate_sort_order("0"), do: :asc
  def translate_sort_order(_any), do: nil

  @spec translate_status(term()) :: term() | nil
  def translate_status("NA"), do: :not_active
  def translate_status("IR-LT"), do: :long_term_injured_reserve
  def translate_status("IR"), do: :injured_reserve
  def translate_status("O"), do: :out
  def translate_status("DTD"), do: :day_to_day
  def translate_status("IR-NR"), do: :non_roster_injured_reserve
  def translate_status(_), do: nil

  @spec transform(map(), Keyword.t()) :: struct()
  def transform(struct, transform_functions) do
    transform_functions
    |> Enum.reduce(%{}, fn {field, transform_function}, acc ->
      transformed_value =
        struct
        |> Map.get(field)
        |> transform_function.()

      Map.put(acc, field, transformed_value)
    end)
  end

  @type position ::
          :center
          | :left_wing
          | :right_wing
          | :forward
          | :defense
          | :goalie
          | :bench
          | :injured_reserve
          | :injured_reserve_plus
          | :invalid

  @spec translate_position(String.t()) :: position()
  def translate_position("C"), do: :center
  def translate_position("LW"), do: :left_wing
  def translate_position("RW"), do: :right_wing
  def translate_position("W"), do: :winger
  def translate_position("F"), do: :forward
  def translate_position("Util"), do: :utility
  def translate_position("D"), do: :defense
  def translate_position("G"), do: :goalie

  def translate_position("QB"), do: :quarterback
  def translate_position("WR"), do: :wide_receiver
  def translate_position("RB"), do: :running_back
  def translate_position("TE"), do: :tight_end
  def translate_position("W/R/T"), do: :flex
  def translate_position("K"), do: :kicker
  def translate_position("DEF"), do: :defense

  def translate_position("PG"), do: :point_guard
  def translate_position("SG"), do: :shooting_guard
  def translate_position("SF"), do: :small_forward
  def translate_position("PF"), do: :power_forward

  def translate_position("IL"), do: :injured_list
  def translate_position("IL+"), do: :injured_list_plus
  def translate_position("BN"), do: :bench
  def translate_position("NA"), do: :not_active
  def translate_position("IR"), do: :injured_reserve
  def translate_position("IR+"), do: :injured_reserve_plus

  def translate_position(nil), do: nil
  def translate_position(_), do: :invalid

  @type position_type :: :player | :goalie | :invalid

  @spec translate_position_type(String.t()) :: position_type()
  def translate_position_type("P"), do: :player
  def translate_position_type("G"), do: :goalie
  def translate_position_type("O"), do: :offense
  def translate_position_type("D"), do: :defense
  def translate_position_type("K"), do: :kicker
  def translate_position_type("B"), do: :batter
  def translate_position_type(nil), do: nil
  def translate_position_type(_), do: :invalid

  def translate_transaction_type("add/drop"), do: :add_drop
  def translate_transaction_type(value), do: cast_atom!(value)

  @spec build_renew_key(String.t()) :: String.t() | nil
  def build_renew_key(""), do: nil
  def build_renew_key(renew_key), do: String.replace(renew_key, "_", ".l.")
end
