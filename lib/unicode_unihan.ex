defmodule Unicode.Unihan do
  @moduledoc """
  Functions to introspect the Unicode Unihan character database.

  The [Unihan database](https://www.unicode.org/reports/tr38/) is the
  Unicode Consortium's repository of information about CJK ideographs:
  readings, meanings, dictionary indices, radical-stroke counts, variants
  and mappings to other character sets. This library ships the database
  for Unicode 18.0 with each property value decoded into an Elixir term,
  so that `kTotalStrokes` is an integer, `kKangXi` is a map of page and
  position, `kCantonese` is a decomposed jyutping reading and so on. The
  decoded shape of every property is documented in the Properties guides.

  The primary API is:

  * `unihan/1` returns the decoded property map for one code point, given
    as an integer, a grapheme or a `U+XXXX` string.

  * `filter/1` and `reject/1` select code points across the whole
    database with an arbitrary predicate over their property maps.

  * `to_string/1` converts a code point, a property map or a list of
    property maps back to graphemes.

  * `unihan_properties/0` returns the property definitions (category,
    status, delimiter, syntax and description) scraped from UAX #38.

  The database is parsed once and held in `:persistent_term`; the first
  lookup in a VM loads it, or `load_unihan/0` can be called at startup.
  Radicals, Cangjie codes and jyutping readings have their own modules:
  `Unicode.Unihan.Radical`, `Unicode.Unihan.Cangjie` and
  `Unicode.Unihan.Cantonese`.

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
  Loads the Unihan database into `:persistent_term`.

  This function is called on the first access by
  `unihan/1`, `filter/1` or `reject/1` but can be called
  at application start to move the load time out of the
  first lookup.

  If an Erlang term format file of the parsed database
  exists it is loaded. If not (the first time the function
  is called after installation), the database is parsed from
  the Unihan text files, saved and then loaded.

  ### Arguments

  * none.

  ### Returns

  * `:ok`.

  ### Examples

      iex> Unicode.Unihan.load_unihan()
      :ok

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

  ### Arguments

  * `codepoint` is an integer code point, a single-grapheme
    string, or a string in the form `U+XXXX` or `U+XXXXX`.

  ### Returns

  * a map of decoded properties keyed by the Unihan property
    name as an atom (for example `:kDefinition`), plus a
    `:codepoint` key holding the integer code point.

  * `nil` if the code point is not in the Unihan database.

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
  Returns the grapheme for a code point, a Unihan
  property map, or a list of property maps.

  ### Arguments

  * `codepoint` is an integer code point, a map with a
    `:codepoint` key as returned by `unihan/1`, or a list
    of such maps.

  ### Returns

  * a single-grapheme string, or a list of them when a list
    of maps is given.

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
  Returns the property definitions of the Unihan
  database as scraped from [UAX #38](https://www.unicode.org/reports/tr38/).

  ### Arguments

  * none.

  ### Returns

  * a map keyed by property name atom. Each value is a map with
    the keys `:name`, `:category`, `:status`, `:delimiter`,
    `:syntax` (the source of a regex matching one value, to be
    compiled with the `:unicode` option), `:description` and `:introduced`.

  ### Examples

      iex> Unicode.Unihan.unihan_properties()[:kTotalStrokes].category
      :irg_sources

      iex> Unicode.Unihan.unihan_properties()[:kFanqie].introduced
      "16.0"

      iex> Unicode.Unihan.unihan_properties()[:kCantonese].syntax
      "[a-z]{1,6}[1-6]"

  """
  @unihan_properties Utils.unihan_properties()
  def unihan_properties do
    @unihan_properties
  end
end
