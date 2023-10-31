defmodule Unicode.Unihan.Radical do
  @moduledoc """
  `Unicode.Unihan.Radical` encapsulates the mapping from CJK radical numbers
  to characters.

  """
  alias Unicode.Unihan.Utils

  @radicals Utils.parse_radicals()
  @max_radical Map.keys(@radicals) |> Enum.max()

  @default_opts [script: :Hant, glyph: :unified_ideograph]

  def radicals do
    @radicals
  end

  @doc """
  Returns grapheme associated with the radical,
  as specified in the [CJK Radicals](https://www.unicode.org/reports/tr41/tr41-30.html#CJKRadicals) file.

  ### Arguments

  * `index` is the Unicode radical number (1..214), reported from various
    radical stroke properties such as `kRSUnicode`.

  * an optional argument, which can be one of:
    * `:unified_ideograph` (default) shows the grapheme in the (normal) CJK
       unified ideograph Unicode block (hexadecimal 4000--6000)
    * `:radical_character` shows the grapheme in the special, contiguous
       KangXi Radical block (2F00--2FD5)
    * `:all` returns the full map for the radical

  ### Examples

      iex> Unicode.Unihan.Radical.radical(187)
      "馬"

      iex> Unicode.Unihan.Radical.radical(187, script: :Hans)
      "马"

      iex> Unicode.Unihan.Radical.radical(187, script: :Hant, glyph: :radical_character)
      "⾺"

      iex> Unicode.Unihan.Radical.radical(213, script: :Hanj)
      "亀"

      iex> Unicode.Unihan.Radical.radical(187) == Unicode.Unihan.Radical.radical(187, script: :Hant, glyph: :radical_character)
      false

      iex> Unicode.Unihan.Radical.radical(187, :all)
      %{
        Hans: %{
          radical_character: 12002,
          radical_number: 187,
          unified_ideograph: 39532
        },
        Hant: %{
          radical_character: 12218,
          radical_number: 187,
          unified_ideograph: 39340
        }
      }

      iex> Unicode.Unihan.Radical.radical(182, :all)
      %{
        Hans: %{
          radical_character: 11995,
          radical_number: 182,
          unified_ideograph: 39118
        },
        Hant: %{
          radical_character: 12213,
          radical_number: 182,
          unified_ideograph: 39080
        },
        Hanj: %{
          radical_character: nil,
          radical_number: 182,
          unified_ideograph: 205508
        }
      }

      iex> Unicode.Unihan.Radical.radical(999)
      {:error, "Invalid radical number. Valid numbers are an integer in the range 1..214"}

  """
  def radical(index, opts \\ [])

  def radical(index, :all) when index in 1..@max_radical do
    Map.get(radicals(), index)
  end

  def radical(index, opts) when index in 1..@max_radical do
    opts = Keyword.merge(@default_opts, opts)

    radicals()
    |> Map.get(index)
    |> Map.get(opts[:script])
    |> Map.get(opts[:glyph])
    |> Unicode.Unihan.to_string()
  end

  def radical(index, _) when not is_integer(index) or index > @max_radical do
    {:error,
     "Invalid radical number. Valid numbers are an integer in the range 1..#{inspect(@max_radical)}"}
  end

  def radical(_index, attr) do
    {:error,
     "Invalid attribute. The keyword list accepts :Hans or :Hant for the :script keyword, and either :unified_ideograph or :radical_character for the :glyph keyword." <>
       "Found #{inspect(attr)}"}
  end

  @doc """
  Filter the Unicode CJK radical database returning selected
  codepoints.

  ### Arguments

  * `fun` is a `1-arity` function that is passed
    the attribute map for a given codepoint. if the
    function returns a `truthy` value then the codepoint
    is included in the returned data. If the return
    value is `falsy` then the codepoint is omitted
    from the returned list.

  ### Returns

  * a map of the filtered codepoints mapped to their
    attributes.

  ### Example

      iex> Unicode.Unihan.Radical.filter(&(&1[:Hant][:radical_number] < 5))
      ...> |> Enum.count()
      4

  """
  def filter(fun) when is_function(fun, 1) do
    Enum.filter(radicals(), fn {_radical_number, value} ->
      fun.(value)
    end)
    |> Map.new()
  end

  @doc """
  Filter the Unicode CJK radical database returning selected
  codepoints that are not rejected by the provided
  function.

  ### Arguments

  * `fun` is a `1-arity` function that is passed
    the attribute map for a given codepoint. if the
    function returns a `falsy` value then the codepoint
    is included in the returned data. If the return
    value is `truthy` then the codepoint is omitted
    from the returned list.

  ### Returns

  * a map of the codepoints that are not rejected
    mapped to their attributes.

  ### Example

      iex> Unicode.Unihan.Radical.reject(&(&1[:Hant][:radical_number] < 5))
      ...> |> Enum.count()
      210

  """
  def reject(fun) when is_function(fun, 1) do
    Enum.reject(radicals(), fn {_radical_number, value} ->
      fun.(value)
    end)
    |> Map.new()
  end
end
