defmodule YahooFantasyEx.Model do
  @moduledoc false
  @spec __using__(Keyword.t()) :: Macro.t()
  defmacro __using__(opts) do
    quote do
      import YahooFantasyEx.Models.Helpers
      alias __MODULE__
      alias YahooFantasyEx.Models.Decoder

      @fields unquote(opts[:fields])

      @type t :: %{}

      @spec new(any()) :: t()
      def new(json), do: Decoder.decode(json, @fields)

      @spec new(any(), map()) :: t()
      def new(decoded, parent), do: Decoder.decode_subresources(decoded, parent, @fields)
    end
  end
end
