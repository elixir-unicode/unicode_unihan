defmodule Unicode.Unihan do
  @moduledoc """
  Functions to introspect the Unicode Unihan character database.

  """
  alias Unicode.Unihan.Utils

  import Kernel, except: [to_string: 1]

  @doc false
  defguard is_hex(c1, c2, c3, c4)
           when c1 in ?0..?9 or c1 in ?A..?Z or
                  (c2 in ?0..?9 or c2 in ?A..?Z) or
                  (c3 in ?0..?9 or c3 in ?A..?Z) or
                  (c3 in ?0..?9 or c4 in ?A..?Z)

  @doc """
  Load the unihan data into :persistent_term.

  This function will be called on the first access
  by `Unicode.Unihan.unihan/1` but can be called
  on application load if required.

  First the existence of an erlang term format
  file of the unihan database is found. If so,
  it is loaded. If not (the first time the function
  is called), the file is generated and then loaded.

  """
  def load_unihan do
    unihan_path = Utils.unihan_path()

    if File.exists?(unihan_path) do
      IO.puts "Loading the Unihan database."
      unihan =
        unihan_path
        |> File.read!
        |> :erlang.binary_to_term()

      Enum.each(unihan, fn {codepoint, data} -> :persistent_term.put({:unihan, codepoint}, data) end)

      unihan_codepoints = Map.keys(unihan)
      :persistent_term.put(:unihan_codepoints, unihan_codepoints)
    else
      IO.puts "Parsing the Unihan database (this may take a few seconds)."
      Utils.save_unihan!
      load_unihan()
    end
  end

  defp unihan_get(codepoint) do
    :persistent_term.get({:unihan, codepoint}, nil) || maybe_load_unihan(codepoint)
  end

  defp unihan_codepoints do
    :persistent_term.get(:unihan_codepoints, nil) || (load_unihan() && unihan_codepoints())
  end

  defp maybe_load_unihan(codepoint) do
    unless :persistent_term.get(:unihan_codepoints, nil) do
      load_unihan()
      unihan_get(codepoint)
    end
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
        kIRG_GSource: %{mapping: ["74674.09"], source: "GHZ"},
        kIRG_TSource: %{mapping: "3043", source: "T4"},
        kIRG_VSource: %{mapping: "29D4B", source: "VN"},
        kJapaneseKun: ["UO", "SAKANA", "SUNADORU"],
        kJapaneseOn: "GYO",
        kKangXi: %{page: 1465, position: 1, virtual: true},
        kNelson: 692,
        kPhonetic: %{class: 1605},
        kRSAdobe_Japan1_6: [
          %{cid: 13717, code: "C", kangxi: 195, strokes_radical: 10, strokes_residue: 0},
          %{cid: 13718, code: "V", kangxi: 195, strokes_radical: 10, strokes_residue: 0}
        ],
        kRSKangXi: %{radical: 195, strokes: 0},
        kRSUnicode: %{radical: 195, simplified_radical: false, strokes: 0},
        kTotalStrokes: %{Hans: 11, Hant: 11}
      }

      iex> Unicode.Unihan.unihan("㝰")
      %{
        codepoint: 14192,
        kCangjie: ["J", "H", "U", "S"],
        kCantonese: %{coda: "n", final: "in", jyutping: "min4", nucleus: "i", onset: "m", tone: "4"},
        kDefinition: ["unable to meet, empty room"],
        kHanYu: %{page: 957, position: 3, virtual: false, volume: 2},
        kHanyuPinyin: %{location: [%{page: 20957, position: 3, virtual: false}], readings: ["mián"]},
        kIRGHanyuDaZidian: %{page: 957, position: 3, virtual: false, volume: 2},
        kIRGKangXi: %{page: 293, position: 1, virtual: false},
        kIRG_GSource: %{mapping: ["3E3C"], source: "G5"},
        kIRG_KSource: %{mapping: "236A", source: "K3"},
        kIRG_TSource: %{mapping: "5A7D", source: "T4"},
        kKangXi: %{page: 293, position: 1, virtual: false},
        kMandarin: "mián",
        kRSUnicode: %{radical: 40, simplified_radical: false, strokes: 15},
        kSBGY: %{page: 135, position: 35},
        kTotalStrokes: %{Hans: 18, Hant: 18}
      }

  """
  def unihan(codepoint) when is_integer(codepoint) do
    unihan_get(codepoint)
  end

  def unihan(<<codepoint::utf8>>) do
   unihan_get(codepoint)
  end

  # U\\+[23]?[0-9A-F]{4}
  def unihan("U+" <> <<c1::utf8, c2::utf8, c3::utf8, c4::utf8>>)
      when is_hex(c1, c2, c3, c4) do
    hex = <<c1::utf8, c2::utf8, c3::utf8, c4::utf8>>

    hex
    |> String.to_integer(16)
    |> unihan_get()
  end

  def unihan("U+" <> <<c1::utf8, c2::utf8, c3::utf8, c4::utf8, c5::utf8, c6::utf8>>)
      when c1 in [?2, ?3] and c2 in [?2, ?3] and is_hex(c3, c4, c5, c6) do
    hex = <<c1::utf8, c2::utf8, c3::utf8, c4::utf8, c5::utf8, c6::utf8>>

    hex
    |> String.to_integer(16)
    |> unihan_get()
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
    <<codepoint::utf8>>
  end

  def to_string(%{codepoint: codepoint}) when is_integer(codepoint) do
    <<codepoint::utf8>>
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

      iex> Unicode.Unihan.filter(&(&1.kTotalStrokes[:"Hans"] > 30))
      ...> |> Enum.count()
      238

      iex> Unicode.Unihan.filter(&(&1.kTotalStrokes[:"Hans"] != &1.kTotalStrokes[:"Hant"]))
      ...> |> Enum.count
      3

      iex> Unicode.Unihan.filter(&(&1[:kGradeLevel] <= 6))
      ...> |> Enum.count
      2632

  """
  def filter(fun) when is_function(fun, 1) do
    Enum.reduce(unihan_codepoints(), Map.new(), fn codepoint, acc ->
      value = unihan_get(codepoint)
      if fun.(value), do: Map.put(acc, codepoint, value), else: acc
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

      iex> Unicode.Unihan.reject(&(&1.kTotalStrokes[:"Hans"] > 30))
      ...> |> Enum.count()
      97822

  """
  def reject(fun) when is_function(fun, 1) do
    Enum.reduce(unihan_codepoints(), Map.new(), fn codepoint, acc ->
      value = unihan_get(codepoint)
      if fun.(value), do: acc, else: Map.put(acc, codepoint, value)
    end)
  end

  @doc """
  Returns the field information for the data in the
  Unihan database.

  """
  @unihan_fields Utils.unihan_fields()
  def unihan_fields do
    @unihan_fields
  end
end
