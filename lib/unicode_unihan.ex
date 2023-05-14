defmodule Unicode.Unihan do
  @moduledoc """
  Functions to introspect the Unicode Unihan character database.

  """

  import Kernel, except: [to_string: 1]

  @doc false
  defguard is_hex(c1, c2, c3, c4)
    when (c1 in ?0..?9 or c1 in ?A..?Z) or
      (c2 in ?0..?9 or c2 in ?A..?Z) or
      (c3 in ?0..?9 or c3 in ?A..?Z) or
      (c3 in ?0..?9 or c4 in ?A..?Z)

  @doc """
  Returns the Unihan database as a mapping
  of a codepoint to its metadata.

  """
  @unihan_data Unicode.Unihan.Utils.parse_files()
  def unihan do
    @unihan_data
  end

  @spec unihan(binary | integer) :: any
  @doc """
  Returns the Unihan database metadata for
  a given codepoint.

  The codepoint can be expressed as an integer
  or a grapheme.

  ### Examples

      iex> Unicode.Unihan.unihan(171339)
      %{
        codepoint: 171339,
        kCantonese: %{coda: "", final: "u", jyutping: "ju4", nucleus: "u", onset: "j", tone: "4"},
        kDefinition: ["(J) nonstandard variant of 魚 U+9B5A, fish"],
        kHanYu: %{page: 4674, position: 9, virtual: false, volume: 7},
        kIRGHanyuDaZidian: %{page: 4674, position: 9, virtual: false, volume: 7},
        kIRGKangXi: %{page: 1465, position: 1, virtual: true},
        kIRG_GSource: "GHZ-74674.09",
        kIRG_TSource: "T4-3043",
        kIRG_VSource: "VN-29D4B",
        kJapaneseKun: ["UO", "SAKANA", "SUNADORU"],
        kJapaneseOn: "GYO",
        kKangXi: %{page: 1465, position: 1, virtual: true},
        kNelson: 692,
        kPhonetic: "1605",
        kRSAdobe_Japan1_6: ["C+13717+195.10.0", "V+13718+195.10.0"],
        kRSKangXi: %{radical: 195, strokes: 0},
        kRSUnicode: %{radical: 195, simplified_radical: false, strokes: 0},
        kTotalStrokes: %{"zh-Hans": 11, "zh-Hant": 11}
      }

      iex> Unicode.Unihan.unihan("㝰")
      %{
        codepoint: 14192,
        kCangjie: ["J", "H", "U", "S"],
        kCantonese: %{coda: "n", final: "in", jyutping: "min4", nucleus: "i", onset: "m", tone: "4"},
        kDefinition: ["unable to meet, empty room"],
        kHanYu: %{page: 957, position: 3, virtual: false, volume: 2},
        kHanyuPinyin: "20957.030:mián",
        kIRGHanyuDaZidian: %{page: 957, position: 3, virtual: false, volume: 2},
        kIRGKangXi: %{page: 293, position: 1, virtual: false},
        kIRG_GSource: "G5-3E3C",
        kIRG_KSource: "K3-236A",
        kIRG_TSource: "T4-5A7D",
        kKangXi: %{page: 293, position: 1, virtual: false},
        kMandarin: "mián",
        kRSUnicode: %{radical: 40, simplified_radical: false, strokes: 15},
        kSBGY: %{page: 135, position: 35},
        kTotalStrokes: %{"zh-Hans": 18, "zh-Hant": 18}
      }

  """
  def unihan(codepoint) when is_integer(codepoint) do
    Map.get(unihan(), codepoint)
  end

  def unihan(<<codepoint::utf8>>) do
    Map.get(unihan(), codepoint)
  end

  # U\\+[23]?[0-9A-F]{4}
  def unihan("U+" <> <<c1::utf8, c2::utf8, c3::utf8, c4::utf8>>)
      when is_hex(c1, c2, c3, c4) do
    hex = <<c1::utf8, c2::utf8, c3::utf8, c4::utf8>>

    hex
    |> String.to_integer(16)
    |> unihan()
  end

  def unihan("U+" <> <<c1::utf8, c2::utf8, c3::utf8, c4::utf8, c5::utf8, c6::utf8>>)
      when c1 in [?2, ?3] and c2 in [?2, ?3] and is_hex(c3, c4, c5, c6) do
    hex = <<c1::utf8, c2::utf8, c3::utf8, c4::utf8, c5::utf8, c6::utf8>>

    hex
    |> String.to_integer(16)
    |> unihan()
  end

  @doc """
  Takes an integer codepoint, a Unihan codepoint map, or list of maps
  and returns the grapheme (or list of graphemes)
  of the codepoint.

  ### Examples

      iex> Unicode.Unihan.to_string(25342)
      "拾"

      iex> Unicode.Unihan.unihan("拾")
      ...> |> Unicode.Unihan.to_string()
      "拾"

  """
  def to_string(codepoint) when is_integer(codepoint) do
    <<codepoint :: utf8>>
  end

  def to_string(%{codepoint: codepoint}) when is_integer(codepoint) do
    <<codepoint :: utf8>>
  end

  def to_string([%{codepoint: codepoint} | _rest] = unihan_list) when is_integer(codepoint) do
    Enum.map(unihan_list, &to_string/1)
  end

  @doc """
  Filter the Unihan database returning selected
  codepoints.

  ### Arguments

  * `fun` is a `1-arity` function that is passed
    the attribute map for a given codepoint. if the
    function returns a `truthy` value then the codepoint
    is included in the returned data. If the return
    value is `falsy` then the codepoint is ommitted
    from the returned list.

  ### Returns

  * a map of the filtered codepoints mapped to their
    attributes.

  ### Example

      iex> Unicode.Unihan.filter(&(&1.kTotalStrokes[:"zh-Hans"] > 30))
      ...> |> Enum.count()
      238

      iex> Unicode.Unihan.filter(&(&1.kTotalStrokes[:"zh-Hans"] != &1.kTotalStrokes[:"zh-Hant"]))
      ...> |> Enum.count
      3

      iex> Unicode.Unihan.filter(&(&1[:kGradeLevel] <= 6))
      ...> |> Enum.count
      2632

  """
  def filter(fun) when is_function(fun, 1) do
    Enum.filter(unihan(), fn {_codepoint, value} ->
      fun.(value)
    end)
  end

  @doc """
  Filter the Unihan database returning selected
  codepoints that are not rejected by the provided
  function.

  ### Arguments

  * `fun` is a `1-arity` function that is passed
    the attribute map for a given codepoint. if the
    function returns a `falsy` value then the codepoint
    is included in the returned data. If the return
    value is `truthy` then the codepoint is ommitted
    from the returned list.

  ### Returns

  * a map of the codepoints that are not rejected
    mapped to their attributes.

  ### Example

      iex> Unicode.Unihan.reject(&(&1.kTotalStrokes[:"zh-Hans"] > 30))
      ...> |> Enum.count()
      97822

  """
  def reject(fun) when is_function(fun, 1) do
    Enum.reject(unihan(), fn {_codepoint, value} ->
      fun.(value)
    end)
  end

  @doc """
  Returns the field information for the data in the
  Unihan database.

  """
  @unihan_fields Unicode.Unihan.Utils.unihan_fields()
  def unihan_fields do
    @unihan_fields
  end
end
