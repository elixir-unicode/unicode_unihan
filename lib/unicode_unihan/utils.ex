defmodule Unicode.Unihan.Utils do
  @moduledoc """
  Functions to parse the Unicode Unihan database
  files.

  """

  alias Unicode.Unihan.Cantonese

  @app_name :unicode_unihan

  @unihan_subdir "unihan"
  @cjk_radicals_file "cjk_radicals.txt"
  @jyutping_index_file "cantonese/jyutping_index.csv"
  @codepoints_file "unihan_codepoints.etf"
  @unihan_etf_file "unihan.etf"
  @unihan_properties_file "unihan_properties.etf"

  def unihan_properties_file do
    @unihan_properties_file
  end

  for file <- Path.wildcard(Path.join(:code.priv_dir(@app_name), "/**/*.{json,txt,csv,etf}")) do
    @external_resource file
  end

  @doc false
  def data_dir do
    :code.priv_dir(@app_name)
  end

  @doc false
  def unihan_path do
    Path.join(data_dir(), @unihan_etf_file)
  end

  @doc false
  def unihan_codepoints_path do
    Path.join(data_dir(), @codepoints_file)
  end

  @doc false
  def save_unihan! do
    unihan = Unicode.Unihan.Utils.parse_files()
    unihan_binary = :erlang.term_to_binary(unihan)
    unihan_path = Unicode.Unihan.Utils.unihan_path()
    File.write!(unihan_path, unihan_binary)
  end

  @doc """
  Parses every Unihan data file in `priv/unihan` and returns
  a mapping from code point to its decoded property map.

  This is the function behind `mix unicode.unihan.download`;
  it takes several seconds for the full database.

  ### Arguments

  * none.

  ### Returns

  * a map of integer code points to property maps.

  ### Examples

      Unicode.Unihan.Utils.parse_files()
      #=> %{19968 => %{codepoint: 19968, kDefinition: ["one", ...], ...}, ...}

  """

  def parse_files do
    data_dir()
    |> Path.join(@unihan_subdir)
    |> File.ls!()
    |> Enum.reduce(%{}, &parse_file(&1, &2))
  end

  @doc """
  Parses one Unihan data file and merges its decoded
  properties into a code point map.

  ### Arguments

  * `file` is the name of a file in `priv/unihan`, for
    example `"Unihan_NumericValues.txt"`.

  * `map` is a map of code points to property maps into
    which the file's properties are merged. The default is
    an empty map.

  ### Returns

  * the updated map of integer code points to property maps.

  ### Examples

      iex> map = Unicode.Unihan.Utils.parse_file("Unihan_NumericValues.txt")
      iex> map[0x842C].kPrimaryNumeric
      10000

  """
  def parse_file(file, map \\ %{}) do
    path = Path.join(data_dir(), [@unihan_subdir, "/", file])
    fields = unihan_properties()

    Enum.reduce(File.stream!(path), map, fn line, map ->
      case line do
        <<"#", _rest::bitstring>> ->
          map

        <<"\n", _rest::bitstring>> ->
          map

        data ->
          [codepoint, key, value] =
            data
            |> String.split("\t")
            |> Enum.map(&String.trim/1)

          codepoint = decode_codepoint(codepoint)
          put_codepoint_metadata(map, codepoint, key, value, fields)
      end
    end)
  end

  defp put_codepoint_metadata(map, codepoint, key, value, fields) do
    map
    |> Map.get_and_update(codepoint, fn
      nil ->
        {key, value} = decode_metadata(key, value, fields)
        {nil, %{key => value, :codepoint => codepoint}}

      current_value when is_map(current_value) ->
        {key, value} = decode_metadata(key, value, fields)
        {current_value, Map.put(current_value, key, value)}
    end)
    |> elem(1)
  end

  @doc """
  Reads the Unihan property definitions from the
  `priv/unihan_properties.etf` file.

  `Unicode.Unihan.unihan_properties/0` returns the same data
  compiled into the module and should be preferred at runtime.

  ### Arguments

  * none.

  ### Returns

  * a map keyed by property name atom; see
    `Unicode.Unihan.unihan_properties/0` for the value shape.

  ### Examples

      iex> Unicode.Unihan.Utils.unihan_properties()[:kCantonese].delimiter
      " "

  """
  def unihan_properties do
    data_dir()
    |> Path.join(@unihan_properties_file)
    |> File.read!()
    |> :erlang.binary_to_term()
  end

  @doc """
  Parses the `priv/cantonese/jyutping_index.csv` file of
  valid jyutping readings.

  ### Arguments

  * none.

  ### Returns

  * a map keyed by jyutping string. Each value is a map with
    the keys `:jyutping`, `:onset`, `:nucleus`, `:coda`,
    `:final` and `:tone`.

  ### Examples

      iex> Unicode.Unihan.Utils.parse_cantonese()["faan1"]
      %{jyutping: "faan1", onset: "f", nucleus: "aa", coda: "n", final: "aan", tone: "1"}

  """
  def parse_cantonese do
    data_dir()
    |> Path.join(@jyutping_index_file)
    |> File.stream!([:trim_bom])
    |> CSV.decode!(headers: true)
    |> Enum.map(fn map ->
      map =
        map
        |> atomize_keys()
        |> Map.put(:final, map["nucleus"] <> map["coda"])

      {map[:jyutping], map}
    end)
    |> Map.new()
  end

  @doc """
  Parses the `priv/cjk_radicals.txt` file of CJK radicals.

  There is one line per CJK radical number. Each line contains three
  fields, separated by a semicolon (';'). The first field is the
  CJK radical number. The second field is the CJK radical character, which may be absent. The third field is the CJK unified ideograph.

  A given radical may have up to four variants, sharing the same radical
  number but described in separate lines. These variants are noted with
  one to three trailing apostrophes `'`:

  * no apostrophe: the traditional radical, stored under `:Hant`.

  * one trailing apostrophe `'`: the Chinese simplified radical, stored
    under `:Hans`.

  * two trailing apostrophes `''`: the first non-Chinese simplified radical
    (Japanese forms, added in Unicode 15.1), stored under `:Hanj`.

  * three trailing apostrophes `'''`: the second non-Chinese simplified
    radical (a Vietnamese form, added in Unicode 18.0), stored under `:Hanv`.

  ### Arguments

  * none.

  ### Returns

  * a map keyed by radical number (1..214). Each value is a map
    of the variants present for that radical, keyed by `:Hant`,
    `:Hans`, `:Hanj` or `:Hanv`, whose values are maps with the
    keys `:radical_number`, `:radical_character` (which may be
    `nil`) and `:unified_ideograph`.

  ### Examples

      iex> Unicode.Unihan.Utils.parse_radicals()[187]
      %{
        Hans: %{radical_number: 187, radical_character: 12002, unified_ideograph: 39532},
        Hant: %{radical_number: 187, radical_character: 12218, unified_ideograph: 39340}
      }

  """
  def parse_radicals do
    path = Path.join(data_dir(), @cjk_radicals_file)

    Enum.reduce(File.stream!(path), %{}, &parse_radical_line/2)
  end

  defp parse_radical_line(<<"#", _rest::bitstring>>, map), do: map
  defp parse_radical_line(<<"\n", _rest::bitstring>>, map), do: map

  defp parse_radical_line(data, map) do
    [radical_number, radical_character, unified_ideograph] =
      data
      |> String.split(";", trim: true)
      |> Enum.map(&String.trim/1)

    {radical_number, variant} = split_radical_number(radical_number)

    radical_character =
      if radical_character == "", do: nil, else: String.to_integer(radical_character, 16)

    unified_ideograph = String.to_integer(unified_ideograph, 16)

    radical = radical(radical_number, variant, radical_character, unified_ideograph)

    other_radical =
      radical(radical_number, variant, radical_character, unified_ideograph)

    put_radical(map, radical_number, radical, other_radical)
  end

  # When no value, assume the current value is for both traditional
  # and simplified. A later entry may overwrite one of them.
  defp put_radical(map, radical_number, radical, other_radical) do
    map
    |> Map.get_and_update(radical_number, fn
      nil ->
        {nil, Map.merge(radical, other_radical)}

      current_value when is_map(current_value) ->
        {current_value, Map.merge(current_value, radical)}
    end)
    |> elem(1)
  end

  defp radical(radical_number, variant, radical_character, unified_ideograph)
       when variant in [:Hant, :Hans, :Hanj, :Hanv] do
    %{variant => radical(radical_number, radical_character, unified_ideograph)}
  end

  defp radical(radical_number, radical_character, unified_ideograph) do
    %{
      radical_number: radical_number,
      radical_character: radical_character,
      unified_ideograph: unified_ideograph
    }
  end

  # Radical variants are represented by radical numbers with up to
  # three trailing apostrophes. See `parse_radicals/0`.

  defp split_radical_number(number) do
    digits = String.trim_trailing(number, "'")
    {_, apostrophes} = String.split_at(number, String.length(digits))
    {String.to_integer(digits), radical_variant(apostrophes)}
  end

  @doc false
  def radical_variant(""), do: :Hant
  def radical_variant("'"), do: :Hans
  def radical_variant("''"), do: :Hanj
  def radical_variant("'''"), do: :Hanv

  defp decode_metadata(key, value, fields) do
    key = String.to_atom(key)

    value =
      key
      |> maybe_split_value(value, fields)
      |> decode_value(key, fields)

    {key, value}
  end

  defp maybe_unwrap([value]), do: value
  defp maybe_unwrap(value), do: value

  defp maybe_split_value(key, value, fields) do
    case Map.fetch(fields, key) do
      {:ok, field} ->
        case field.delimiter do
          nil -> value
          delimiter -> String.split(value, delimiter)
        end

      :error ->
        raise RuntimeError, "Unknown field #{inspect(key)} found for #{inspect(value)}"
    end
  end

  # Values where decoding depends on the number of items
  # in the value list go here - before the clause
  # that maps over a list of values individually.

  # Since Unicode 16.0 kTotalStrokes carries a single IRG stroke count;
  # the earlier "zh hant" pair form no longer appears in the data.
  defp decode_value(value, :kTotalStrokes, _fields) when is_binary(value) do
    String.to_integer(value)
  end

  # When its a list, map each value to decode it.
  # Most decode_value clauses should go below this one.
  # Whenever the list contains only one member, we unwrap the list
  # for easier access

  defp decode_value(value, key, fields) when is_list(value) do
    value
    |> Enum.map(&decode_value(&1, key, fields))
    |> maybe_unwrap()
  end

  defp decode_value(value, :kAccountingNumeric, _fields) do
    String.to_integer(value)
  end

  # Note: kAlternateTotalStrokes is passed through unparsed for now.
  defp decode_value(value, :kAlternateTotalStrokes, _fields) do
    value
  end

  defp decode_value(value, :kBigFive, _fields) do
    Integer.parse(value, 16)
  end

  defp decode_value(value, :kCangjie, _fields) do
    String.graphemes(value)
  end

  defp decode_value(value, :kCantonese, _fields) do
    Cantonese.to_jyutping!(value)
  end

  defp decode_value(value, :kCCCII, _fields) do
    value
  end

  defp decode_value(value, :kCheungBauer, _fields) do
    ~r|(?<radical>[0-9]{3})\/(?<stroke>[0-9]{2});(?<cangjie>[A-Z]*);(?<jyutpings>[a-z1-6\[\]\/,]+)|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kCheungBauerIndex, _fields) do
    ~r|(?<page>[0-9]{3})\.(?<position>[01][0-9])|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kCihaiT, _fields) do
    ~r|(?<page>[1-9][0-9]{0,3})\.(?<row>[0-9])(?<position>[0-9]{2})|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kCNS1986, _fields) do
    value
  end

  defp decode_value(value, :kCNS1992, _fields) do
    value
  end

  defp decode_value(value, :kCompatibilityVariant, _fields) do
    decode_codepoint(value)
  end

  defp decode_value(value, :kCowles, _fields) do
    # The fractional value is dropped
    {index, _fraction} = Integer.parse(value)
    index
  end

  defp decode_value(value, :kDaeJaweon, _fields) do
    ~r|(?<page>[0-9]{4})\.(?<position>[0-9]{2})(?<virtual>[01])|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kDefinition, _fields) do
    String.split(value, ";")
  end

  defp decode_value(value, :kEACC, _fields) do
    String.to_integer(value, 16)
  end

  # A pair of ideographs giving the initial and final of a reading.
  defp decode_value(value, :kFanqie, _fields) do
    value
  end

  defp decode_value(value, :kFenn, _fields) do
    ~r|(?<fenn_phonetic>[0-9]+)a?(?<importance>[A-KP*])|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kFennIndex, _fields) do
    ~r|(?<page>[0-9][0-9]{0,2})\.(?<position>[01][0-9])|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  # despite decimal-looking, this is not a numerical index
  defp decode_value(value, :kFourCornerCode, _fields) do
    codes =
      value
      |> String.graphemes()
      |> Enum.reject(&(&1 == "."))
      |> Enum.map(&String.to_integer/1)

    [:upper_left, :upper_right, :lower_left, :lower_right, :center]
    |> Enum.zip(codes)
    |> Map.new()
  end

  defp decode_value(value, :kGB0, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kGB1, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kGB3, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kGB5, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kGB8, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kGradeLevel, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kGSR, _fields) do
    ~r|(?<index>[0-9]{4})(?<letter>[a-vx-z])(?<prime>\'?)|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kHangul, _fields) do
    case String.split(value, ":", trim: true) do
      [grapheme] -> %{grapheme: grapheme, source: nil}
      [grapheme, source] -> %{grapheme: grapheme, source: source}
    end
  end

  defp decode_value(value, :kHanYu, _fields) do
    ~r|(?<volume>[1-8])(?<page>[0-9]{4})\.(?<position>[0-3][0-9])(?<virtual>[0-3])|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kHanyuPinlu, _fields) do
    ~r|(?<reading>\S+)\((?<frequency>[0-9]+)\)|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kHanyuPinyin, _fields) do
    [locations, readings] = String.split(value, ":")

    locations =
      locations
      |> String.split(",")
      |> Enum.map(fn location ->
        ~r|(?<page>[1-8][0-9]{4})\.(?<position>[0-3][0-9])(?<virtual>[0-3])|
        |> Regex.named_captures(location)
        |> decode_captures()
      end)

    readings =
      readings
      |> String.split(",")

    %{
      location: locations,
      readings: readings
    }
  end

  defp decode_value(value, :kHDZRadBreak, _fields) do
    # don't really understand what this field is for?  JC 2023-05
    ~r|\S+\[(?<hex_codepoint>U\+2F[0-9A-D][0-9A-F])\]:(?<volume>[1-8])(?<page>[0-9]{4})\.(?<position>[0-3][0-9])(?<virtual>0)|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kHKGlyph, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kIBMJapan, _fields) do
    String.to_integer(value, 16)
  end

  defp decode_value(value, :kIICore, _fields) do
    [priority | irg] = String.graphemes(value)

    %{
      priority: priority,
      irg: irg
    }
  end

  defp decode_value(value, :kIRG_GSource, _fields) do
    [source | mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRG_HSource, _fields) do
    [source, mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRG_JSource, _fields) do
    [source, mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRG_KPSource, _fields) do
    [source, mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRG_KSource, _fields) do
    [source, mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRG_MSource, _fields) do
    [source, mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRG_SSource, _fields) do
    [source, mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRG_TSource, _fields) do
    [source, mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRG_UKSource, _fields) do
    [source, mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRG_USource, _fields) do
    [source, mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRG_VSource, _fields) do
    [source, mapping] = String.split(value, "-")
    %{source: source, mapping: mapping}
  end

  defp decode_value(value, :kIRGHanyuDaZidian, _fields) do
    ~r|(?<volume>[1-8])(?<page>[0-9]{4})\.(?<position>[0-3][0-9])(?<virtual>[01])|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  # Kana readings: hiragana for kun-yomi, katakana for on-yomi.
  defp decode_value(value, :kJapanese, _fields) do
    value
  end

  defp decode_value(value, :kJapaneseKun, _fields) do
    value
  end

  defp decode_value(value, :kJapaneseOn, _fields) do
    value
  end

  defp decode_value(value, :kJapaneseNewVariant, _fields) do
    decode_codepoint(value)
  end

  defp decode_value(value, :kJapaneseOldVariant, _fields) do
    decode_codepoint(value)
  end

  defp decode_value(value, :kJinmeiyoKanji, _fields) do
    [year | codepoint] = String.split(value, ":")

    case codepoint do
      [] ->
        %{year: String.to_integer(year)}

      _ ->
        %{
          year: String.to_integer(year),
          codepoint: codepoint |> Enum.at(0) |> decode_codepoint()
        }
    end
  end

  defp decode_value(value, :kJis0, _fields) do
    value
  end

  defp decode_value(value, :kJis1, _fields) do
    value
  end

  defp decode_value(value, :kJIS0213, _fields) do
    value
  end

  defp decode_value("U+" <> codepoint, :kJoyoKanji, _fields) do
    %{codepoint: String.to_integer(codepoint, 16)}
  end

  defp decode_value(year, :kJoyoKanji, _fields) do
    %{year: String.to_integer(year)}
  end

  defp decode_value(value, :kKangXi, _fields) do
    ~r|(?<page>[0-9]{4})\.(?<position>[0-9]{2})(?<virtual>[01])|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kKarlgren, _fields) do
    {index, trail} = Integer.parse(value)
    %{index: index, trail: trail}
  end

  defp decode_value(value, :kKorean, _fields) do
    value
  end

  defp decode_value(value, :kKoreanEducationHanja, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kKoreanName, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kLau, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kMainlandTelegraph, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kMandarin, _fields) do
    value
  end

  defp decode_value(value, :kMatthews, _fields) do
    # not clear what trailing a or 0.5 represents
    {index, trail} = Integer.parse(value)

    %{
      index: index,
      trailing: trail
    }
  end

  defp decode_value(value, :kMeyerWempe, _fields) do
    # not clear what "subsidiary letters" represent
    ~r|(?<index>[1-9][0-9]{0,3})(?<letter>[a-t*]?)|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  # A five-digit index with up to two primes, or an "H"-prefixed three-digit
  # index into the supplemental volume, optionally followed by a variation
  # selector that identifies a specific glyph.
  # A Moji Jōhō Kiban database serial number, optionally followed by a
  # variation selector identifying a specific glyph.
  defp decode_value(value, :kMojiJoho, _fields) do
    ~r|^(?<id>MJ[0-9]{6})(:(?<variation_selector>FE0[01]\|E01[01][0-9A-F]))?$|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kMorohashi, _fields) do
    ~r|^(?<supplement>H?)(?<index>[0-9]{3,5})(?<prime>\'{0,2})(:(?<variation_selector>FE0[01]\|E010[0-9A-F]))?$|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kNelson, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kOtherNumeric, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kPhonetic, _fields) do
    {class, trail} = Integer.parse(value)

    case trail do
      "" -> %{class: class}
      "*" -> %{class: class, implicit: true}
      "x" -> %{class: class, error: true}
      _ -> %{class: class, subsidiary: trail}
    end
  end

  defp decode_value(value, :kPrimaryNumeric, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kPseudoGB1, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kRSAdobe_Japan1_6, _fields) do
    ~r|(?<code>[CV])\+(?<cid>[0-9]{1,5})\+(?<kangxi>[1-9][0-9]{0,2})\.(?<strokes_radical>[1-9][0-9]?)\.(?<strokes_residue>[0-9]{1,2})|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  # The apostrophes after the radical select a variant of the radical, using
  # the same script keys as `Unicode.Unihan.Radical`: none is the traditional
  # radical, one is the Chinese simplified radical, two and three are the
  # first and second non-Chinese simplified radicals.
  defp decode_value(value, :kRSUnicode, _fields) do
    ~r|^(?<radical>[1-9][0-9]{0,2})(?<variant>\'{0,3})\.(?<strokes>-?[0-9]{1,2})$|
    |> Regex.named_captures(value)
    |> decode_captures()
    |> case do
      %{variant: variant} = captures ->
        captures
        |> Map.delete(:variant)
        |> Map.put(:simplified_radical, variant == :Hans)
        |> Map.put(:script, variant)

      nil ->
        nil
    end
  end

  defp decode_value(value, :kSBGY, _fields) do
    ~r|(?<page>[0-9]{3})\.(?<position>[0-7][0-9])|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kSemanticVariant, _fields) do
    list = String.split(value, "<")
    codepoint = Enum.at(list, 0) |> decode_codepoint()
    sources = Enum.at(list, 1)

    # This does not split the source by its trailing : descriptor
    case sources do
      nil ->
        %{codepoint: codepoint}

      _ ->
        %{
          codepoint: codepoint,
          sources:
            sources
            |> String.split(",")
        }
    end
  end

  defp decode_value(value, :kSimplifiedVariant, _fields) do
    decode_codepoint(value)
  end

  defp decode_value(value, :kSMSZD2003Index, _fields) do
    ~r|^(?<page>[0-9]{1,3})\.(?<position>[0-9]{2})$|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  # Mandarin readings in pinyin, then U+7CB5 粵, then Cantonese readings in
  # jyutping. Readings this dictionary considers polysyllabic are kept as
  # strings since they are not valid jyutping.
  defp decode_value(value, :kSMSZD2003Readings, _fields) do
    case String.split(value, "粵") do
      [mandarin, cantonese] ->
        %{mandarin: String.split(mandarin, ","), cantonese: jyutpings(cantonese)}

      _other ->
        value
    end
  end

  defp decode_value(value, :kSpecializedSemanticVariant, _fields) do
    list = String.split(value, "<")
    codepoint = Enum.at(list, 0) |> decode_codepoint()
    sources = Enum.at(list, 1)

    case sources do
      nil ->
        %{codepoint: codepoint}

      _ ->
        %{
          codepoint: codepoint,
          sources:
            sources
            |> String.split(",")
        }
    end
  end

  defp decode_value(value, :kSpoofingVariant, _fields) do
    decode_codepoint(value)
  end

  defp decode_value("A", :kStrange, _fields) do
    %{category: :asymmetric}
  end

  defp decode_value("C", :kStrange, _fields) do
    %{category: :cursive}
  end

  defp decode_value("U", :kStrange, _fields) do
    %{category: :unusual}
  end

  defp decode_value("B:" <> value, :kStrange, _fields) do
    %{category: :bopomofo, codepoint: decode_codepoint(value)}
  end

  defp decode_value("S:" <> value, :kStrange, _fields) do
    %{category: :stroke_heavy, strokes: String.to_integer(value)}
  end

  defp decode_value(value, :kStrange, _fields) do
    [category | unicode] = String.split(value, ":")
    category = strange_category(category)
    codepoints = Enum.map(unicode, &decode_codepoint/1)

    if codepoints == [] do
      %{category: category}
    else
      %{category: category, codepoints: codepoints}
    end
  end

  defp decode_value(value, :kTaiwanTelegraph, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kTang, _fields) do
    ~r|(?<frequent>\*?)(?<reading>\S+)|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kTayNumeric, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kTGH, _fields) do
    ~r|(?<year>20[0-9]{2}):(?<index>[1-9][0-9]{0,3})|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  defp decode_value(value, :kTGHZ2013, _fields) do
    value
  end

  defp decode_value(value, :kTraditionalVariant, _fields) do
    decode_codepoint(value)
  end

  defp decode_value(value, :kUnihanCore2020, _fields) do
    String.graphemes(value)
  end

  defp decode_value(value, :kVietnamese, _fields) do
    value
  end

  defp decode_value(value, :kVietnameseNumeric, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kXerox, _fields) do
    value
  end

  defp decode_value(value, :kXHC1983, _fields) do
    ~r|(?<page>[0-9]{4})\.(?<position>[0-9]{2})(?<entry>[0-9])\*?(,[0-9]{4}\.[0-9]{3}\*?)*:(?<reading>\S+)|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  # A trailing asterisk marks a reading that is not part of the
  # Standard Zhuang lexicon.
  defp decode_value(value, :kZhuang, _fields) do
    case String.split_at(value, -1) do
      {reading, "*"} -> %{reading: reading, standard: false}
      _other -> %{reading: value, standard: true}
    end
  end

  defp decode_value(value, :kZhuangNumeric, _fields) do
    String.to_integer(value)
  end

  defp decode_value(value, :kZVariant, _fields) do
    # Note: the source (the section after `<`) is not yet captured separately.
    ~r|(?<hex_codepoint>U\+[23]?[0-9A-F]{4})(<[ks][A-Za-z0-9_]+(:[TBZ]+)?(,[ks][A-Za-z0-9_]+(:[TBZ]+)?)*)?|
    |> Regex.named_captures(value)
    |> decode_captures()
  end

  # The default decoding is to do nothing.

  defp decode_value(value, _key, _fields) do
    value
  end

  # Categories that may carry a list of related code points. The single
  # letter categories (A, C, U) and those with a non-codepoint payload
  # (B, S) are handled by the clauses above.
  defp strange_category("F"), do: :fully_reflective
  defp strange_category("H"), do: :hangul
  defp strange_category("I"), do: :incomplete
  defp strange_category("K"), do: :katakana
  defp strange_category("M"), do: :mirrored
  defp strange_category("O"), do: :odd
  defp strange_category("R"), do: :rotated
  defp strange_category("Y"), do: :symmetric
  defp strange_category(other), do: {:unknown, other}

  # Decodes a standard `U+xxxx` codepoint into
  # its integer form.

  defp decode_codepoint("U+" <> codepoint) do
    String.to_integer(codepoint, 16)
  end

  @doc false
  def normalize_atom(category) do
    category
    |> String.downcase()
    |> String.replace(" ", "_")
    |> String.to_atom()
  end

  # Convert captures to atom keys and
  # decoded value (by default try to convert
  # the value to an integer)

  defp decode_captures(nil) do
    nil
  end

  defp decode_captures(map) do
    map
    |> Enum.map(&decode_capture/1)
    |> Enum.reject(&is_nil/1)
    |> Map.new()
  end

  defp decode_capture({"virtual", "0"}) do
    {:virtual, false}
  end

  defp decode_capture({"virtual", "1"}) do
    {:virtual, true}
  end

  defp decode_capture({"frequent", ""}) do
    {:frequent, false}
  end

  defp decode_capture({"frequent", "*"}) do
    {:frequent, true}
  end

  defp decode_capture({"variant", apostrophes}) do
    {:variant, radical_variant(apostrophes)}
  end

  defp decode_capture({"supplement", "H"}) do
    {:supplement, true}
  end

  defp decode_capture({"supplement", ""}) do
    {:supplement, false}
  end

  defp decode_capture({"variation_selector", ""}) do
    nil
  end

  defp decode_capture({"variation_selector", hex}) do
    {:variation_selector, String.to_integer(hex, 16)}
  end

  defp decode_capture({"hex_codepoint", value}) do
    {:codepoint, decode_codepoint(value)}
  end

  defp decode_capture({"jyutpings", value}) do
    {:jyutpings, jyutpings(value)}
  end

  defp decode_capture({key, value}) do
    key = String.to_atom(key)

    value =
      case Integer.parse(value) do
        {integer, ""} -> integer
        _other -> value
      end

    {key, value}
  end

  # Decodes a comma-separated list of jyutping readings, keeping any
  # reading that is not valid jyutping as a string.
  defp jyutpings(value) do
    value
    |> String.split(",")
    |> Enum.map(fn jyutping ->
      case Cantonese.to_jyutping(jyutping) do
        {:ok, jyutping_map} -> jyutping_map
        _other -> jyutping
      end
    end)
  end

  defp atomize_keys(map) do
    map
    |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
    |> Map.new()
  end
end
