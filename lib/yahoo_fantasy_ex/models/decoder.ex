defmodule YahooFantasyEx.Models.Decoder do
  @moduledoc false

  alias YahooFantasyEx.Models.Decoder.Function
  alias YahooFantasyEx.Models.Decoder.Primitive
  alias YahooFantasyEx.Models.Decoder.Subresource

  @spec decode(any(), any()) :: {:error, Jason.DecodeError.t()} | map()
  def decode(decoded, fields) do
    flattened = flatten_attributes(decoded)
    Map.new(fields, &parse(&1, flattened))
  end

  def decode_subresources(decoded, parent, fields) do
    flattened = flatten_attributes(decoded)
    Map.new(fields, &parse(&1, flattened, parent))
  end

  defp parse({field, type_or_func}, entity, parent \\ nil) do
    {field, do_parse(type_or_func, Map.get(entity, field), entity, parent)}
  end

  defp do_parse(function, value, decoded, parent) when is_function(function),
    do: Function.apply(function, value, decoded, parent)

  defp do_parse({:array, function}, value, decoded, parent) when is_function(function),
    do: Function.apply_many(function, value, decoded, parent)

  defp do_parse({:many, _module}, nil, _decoded, _parent), do: []

  defp do_parse({:many, module}, value, decoded, _parent),
    do: Subresource.build(value, module, decoded)

  defp do_parse({:one, _module}, nil, _decoded, _parent), do: nil

  defp do_parse({:one, module}, value, decoded, _parent),
    do: Subresource.build(value, module, decoded)

  defp do_parse({:array, type}, value, _decoded, _parent), do: Primitive.cast_many(type, value)
  defp do_parse(type, value, _decoded, _parent), do: Primitive.cast(type, value)

  defp flatten_attributes(attributes) do
    attributes
    |> List.flatten()
    |> Enum.reduce(&Map.merge(&1, &2, fn _k, v1, v2 -> v2 ++ v1 end))
  end

  defmodule Primitive do
    @moduledoc false
    alias YahooFantasyEx.Models.Helpers

    def cast(:atom, value), do: Helpers.cast_atom!(value)
    def cast(:boolean, value), do: Helpers.cast_boolean(value)
    def cast(:date, value), do: Helpers.cast_date(value)
    def cast(:float, value), do: Helpers.cast_float(value)
    def cast(:integer, value), do: Helpers.cast_integer(value)
    def cast(:string, value), do: value

    def cast_many(type, values), do: Enum.map(values, &cast(type, &1))
  end

  defmodule Function do
    @moduledoc false
    def apply(function, value, _decoded, _parent) when is_function(function, 1),
      do: function.(value)

    def apply(function, value, decoded, _parent) when is_function(function, 2),
      do: function.(value, decoded)

    def apply(function, value, decoded, parent) when is_function(function, 3),
      do: function.(value, decoded, parent)

    def apply_many(function, values, decoded, parent),
      do: Enum.map(values, &apply(function, &1, decoded, parent))
  end

  defmodule Subresource do
    @moduledoc false
    def build(value, module, decoded) do
      value
      |> Enum.reduce([], &flatten/2)
      |> Enum.map(&module.new(&1, decoded))
    end

    defp flatten({_, data}, acc) when is_map(data) do
      flattened =
        data
        |> Map.values()
        |> List.flatten()

      acc ++ [flattened]
    end

    defp flatten(_, acc), do: acc
  end
end
