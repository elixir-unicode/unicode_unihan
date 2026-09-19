defmodule Unicode.Unihan do
  @moduledoc """
  Functions to introspect the Unicode Unihan character database.

  """

  require Logger
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
      Logger.info("Loading the Unihan database")

      unihan =
        unihan_path
        |> File.read!()
        |> :erlang.binary_to_term()

      Enum.each(unihan, fn {codepoint, data} ->
        :persistent_term.put({:unihan, codepoint}, data)
      end)

      unihan_codepoints = Map.keys(unihan)
      :persistent_term.put(:unihan_codepoints, unihan_codepoints)
    else
      Logger.info("Parsing the Unihan database (this may take a few seconds)")
      Utils.save_unihan!()
      load_unihan()
    end
  end

  defp unihan_get(codepoint) do
    :persistent_term.get({:unihan, codepoint}, nil) || maybe_load_unihan(codepoint)
  end

  defp unihan_codepoints do
    case :persistent_term.get(:unihan_codepoints, nil) do
      nil ->
        load_unihan()
        unihan_codepoints()

      codepoints ->
        codepoints
    end
  end

  defp maybe_load_unihan(codepoint) do
    unless already_loaded?() do
      load_unihan()
      unihan_get(codepoint)
    end
  end

  defp already_loaded? do
    :persistent_term.get(:unihan_codepoints, nil)
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
        kTotalStrokes: 10,
        kCantonese: %{
          final: "u",
          jyutping: "ju4",
          coda: "",
          nucleus: "u",
          onset: "j",
          tone: "4"
        },
        kDefinition: ["(non-standard Japanese variant of 魚) fish"],
        kHanYu: %{position: 9, virtual: false, page: 4674, volume: 7},
        kIRG_GSource: %{source: "GHZ", mapping: ["74674.09"]},
        kIRG_JSource: %{source: "JMJ", mapping: "055080"},
        kIRG_TSource: %{source: "T4", mapping: "3043"},
        kIRG_VSource: %{source: "VN", mapping: "29D4B"},
        kIRGHanyuDaZidian: %{position: 9, virtual: false, page: 4674, volume: 7},
        kJapaneseKun: ["UO", "SAKANA", "SUNADORU"],
        kJapaneseOn: "GYO",
        kKangXi: %{position: 1, virtual: true, page: 1465},
        kMorohashi: %{index: 45958, supplement: false, prime: ""},
        kNelson: 692,
        kPhonetic: %{class: 1605},
        kRSAdobe_Japan1_6: [
          %{
            code: "C",
            cid: 13717,
            kangxi: 195,
            strokes_radical: 10,
            strokes_residue: 0
          },
          %{
            code: "V",
            cid: 13718,
            kangxi: 195,
            strokes_radical: 10,
            strokes_residue: 0
          }
        ],
        kRSUnicode: %{radical: 195, strokes: 0, simplified_radical: false, script: :Hant},
        kJapanese: ["ギョ", "うお"],
        kMojiJoho: %{id: "MJ055080"}
      }

      iex> Unicode.Unihan.unihan("㝰")
      %{
        codepoint: 14192,
        kTotalStrokes: 18,
        kCangjie: ["J", "H", "U", "S"],
        kCantonese: %{
          final: "in",
          jyutping: "min4",
          coda: "n",
          nucleus: "i",
          onset: "m",
          tone: "4"
        },
        kDefinition: ["unable to meet, empty room"],
        kFanqie: "莫賢",
        kGB5: 3028,
        kHanYu: %{position: 3, virtual: false, page: 957, volume: 2},
        kHanyuPinyin: %{
          location: [%{position: 3, virtual: false, page: 20957}],
          readings: ["mián"]
        },
        kIRG_GSource: %{source: "G5", mapping: ["3E3C"]},
        kIRG_JSource: %{source: "JMJ", mapping: "000772"},
        kIRG_KSource: %{source: "K3", mapping: "236A"},
        kIRG_TSource: %{source: "T4", mapping: "5A7D"},
        kIRGHanyuDaZidian: %{position: 3, virtual: false, page: 957, volume: 2},
        kKangXi: %{position: 1, virtual: false, page: 293},
        kMandarin: "mián",
        kMorohashi: %{index: 7359, supplement: false, prime: ""},
        kRSUnicode: %{radical: 40, strokes: 15, simplified_radical: false, script: :Hant},
        kSBGY: %{position: 35, page: 135},
        kJapanese: ["ベン", "メン"],
        kMojiJoho: %{id: "MJ000772"}
      }

      iex> Unicode.Unihan.unihan("U+9B5A").codepoint
      39770

      iex> Unicode.Unihan.unihan("U+29D4B").codepoint
      171339

  """
  def unihan(codepoint) when is_integer(codepoint) do
    unihan_get(codepoint)
  end

  def unihan(<<codepoint::utf8>>) do
    unihan_get(codepoint)
  end

  # U\\+[0-9A-F]{4} — a four hex-digit codepoint in the Basic Multilingual Plane.
  def unihan("U+" <> <<c1::utf8, c2::utf8, c3::utf8, c4::utf8>>)
      when is_hex(c1, c2, c3, c4) do
    hex = <<c1::utf8, c2::utf8, c3::utf8, c4::utf8>>

    hex
    |> String.to_integer(16)
    |> unihan_get()
  end

  # U\\+[23][0-9A-F]{4} — a five hex-digit codepoint in the Supplementary
  # Ideographic Plane (plane 2) or Tertiary Ideographic Plane (plane 3),
  # covering the CJK Unified Ideographs Extension B and later blocks.
  def unihan("U+" <> <<plane::utf8, c1::utf8, c2::utf8, c3::utf8, c4::utf8>>)
      when plane in [?2, ?3] and is_hex(c1, c2, c3, c4) do
    hex = <<plane::utf8, c1::utf8, c2::utf8, c3::utf8, c4::utf8>>

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
    value is `falsy` then the codepoint is omitted
    from the returned list.

  ### Returns

  * a map of the filtered codepoints mapped to their
    attributes.

  ### Examples

      iex> Unicode.Unihan.filter(&(&1.kTotalStrokes > 30))
      ...> |> Enum.count()
      258

      iex> Unicode.Unihan.filter(fn unihan ->
      ...>   unihan[:kRSUnicode] |> List.wrap() |> Enum.any?(&(&1.script == :Hanv))
      ...> end)
      ...> |> Enum.count()
      6

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
    value is `truthy` then the codepoint is omitted
    from the returned list.

  ### Returns

  * a map of the codepoints that are not rejected
    mapped to their attributes.

  ### Examples

      iex> Unicode.Unihan.reject(&(&1.kTotalStrokes > 30))
      ...> |> Enum.count()
      102741

  """
  def reject(fun) when is_function(fun, 1) do
    Enum.reduce(unihan_codepoints(), Map.new(), fn codepoint, acc ->
      value = unihan_get(codepoint)
      if fun.(value), do: acc, else: Map.put(acc, codepoint, value)
    end)
  end

  @doc """
  Returns the property information for the data in the
  Unihan database.

  """
  @unihan_properties Utils.unihan_properties()
  def unihan_properties do
    @unihan_properties
  end
end
