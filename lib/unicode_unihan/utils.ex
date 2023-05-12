defmodule Unicode.Unihan.Utils do
  @moduledoc """
  Functions to parse the Unicode Unihand database
  files.

  """
  for file <- Path.wildcard(Path.join(__DIR__, "../../data/**/**")) do
    @external_resource file
  end

  @doc false
  @data_dir Path.join(__DIR__, "../../data") |> Path.expand()
  def data_dir do
    @data_dir
  end

  @doc """
  Parse all Unicode Unihan files and return
  a mapping from codepoint to a map of metadata
  for that codepoint.

  """
  @subdir "unihan"
  def parse_files do
    @data_dir
    |> Path.join(@subdir)
    |> File.ls!()
    |> Enum.reduce(%{}, &parse_file(&1, &2))
  end

  @doc """
  Parse one Unicode Unihan file and return
  a mapping from codepoint to a map of metadata
  for that codepoint.

  """
  def parse_file(file, map \\ %{}) do
    path = Path.join(@data_dir, [@subdir, "/", file])
    fields = unihan_fields()

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

          Map.get_and_update(map, codepoint, fn
            nil ->
              {key, value} = decode_metadata(key, value, fields)
              {nil, %{key => value, :codepoint => codepoint}}

            current_value when is_map(current_value) ->
              {key, value} = decode_metadata(key, value, fields)
              {current_value, Map.put(current_value, key, value)}
          end)
          |> elem(1)
      end
    end)
  end

  @doc """
  Returns a map of the field definitions for a
  Unihan codepoint.

  """
  def unihan_fields do
    @data_dir
    |> Path.join("unihan_fields.json")
    |> File.read!()
    |> Jason.decode!()
    |> Map.get("records")
    |> Enum.map(fn map ->
      fields = Map.get(map, "fields")
      {name, fields} = Map.pop(fields, "name")

      fields =
        Enum.map(fields, fn
          {"Status", status} ->
            {:status, normalize_atom(status)}

          {"delimiter", "space"} ->
            {:delimiter, "\s"}

          {"delimiter", "N/A"} ->
            {:delimiter, nil}

          {"category", category} ->
            {:category, normalize_atom(category)}

          {"syntax", syntax} when is_binary(syntax) ->
            {:syntax, Regex.compile!(syntax, [:unicode])}

          {field, value} ->
            {String.to_atom(field), value}
        end)
        |> Map.new()

      {String.to_atom(name), fields}
    end)
    |> Map.new()
  end

  defp decode_metadata(key, value, fields) do
    key = String.to_atom(key)

    value =
      key
      |> maybe_split_value(value, fields)
      |> decode_value(key, fields)

    {key, value}
  end

  defp maybe_split_value(key, value, fields) do
    field = Map.fetch!(fields, key)

    case field.delimiter do
      nil -> value
      delimiter -> String.split(value, delimiter)
    end
  end

  # Values where decoding depends on the number of items
  # in the value list go here - before the clause
  # that maps over a list of values individually.

  def decode_value(value, :kTotalStrokes, _fields) do
    case Enum.map(value, &String.to_integer/1) do
      [zh] -> %{"zh-Hans": zh, "zh-Hant": zh}
      [hans, hant] -> %{"zh-Hans": hans, "zh-Hant": hant}
    end
  end

  # When its a list, map each value to decode it.
  # Most decode_value clauses should go below this one.
  # Whenever the list contains only one member, we unwrap the list
  # for easier access

  def decode_value(value, key, fields) when is_list(value) do
    list = Enum.map(value, &decode_value(&1, key, fields))
    if length(list) > 1 do
      list
    else
      List.first(list)
    end
  end

  def decode_value(value, :kAccountingNumeric, _fields), do:
    String.to_integer(value)

  def decode_value(value, :kAlternateTotalStrokes, _fields) do
    value # TODO: this is abit messy
  end

  def decode_value(value, :kBigFive, _fields), do:
    String.to_integer(value, 16)

  def decode_value(value, :kCangjie, _fields), do:
    String.graphemes(value)

  def decode_value(value, :kCantonese, _fields) do
    value
  end

  def decode_value(value, :kCCCII, _fields) do
    value
  end

  def decode_value(value, :kCheungBauer, _fields) do
    value
  end

  def decode_value(value, :kCheungBauerIndex, _fields) do
    value
  end

  def decode_value(value, :kCihaiT, _fields) do
    value
  end

  def decode_value(value, :kCNS1986, _fields) do
    value
  end

  def decode_value(value, :kCNS1992, _fields) do
    value
  end

  def decode_value(value, :kCompatibilityVariant, _fields) do
    value
  end

  def decode_value(value, :kCowles, _fields) do
    value
  end

  def decode_value(value, :kDaeJaweon, _fields) do
    value
  end

  def decode_value(value, :kDefinition, _fields) do
    value
  end

  def decode_value(value, :kEACC, _fields) do
    value
  end

  def decode_value(value, :kFenn, _fields) do
    value
  end

  def decode_value(value, :kFennIndex, _fields) do
    value
  end

  def decode_value(value, :kFourCornerCode, _fields) do
    value
  end

  def decode_value(value, :kFrequency, _fields) do
    value
  end

  def decode_value(value, :kGB0, _fields) do
    value
  end

  def decode_value(value, :kGB1, _fields) do
    value
  end

  def decode_value(value, :kGB3, _fields) do
    value
  end

  def decode_value(value, :kGB5, _fields) do
    value
  end

  def decode_value(value, :kGB7, _fields) do
    value
  end

  def decode_value(value, :kGB8, _fields) do
    value
  end

  def decode_value(value, :kGradeLevel, _fields) do
    String.to_integer(value)
  end

  def decode_value(value, :kGSR, _fields) do
    value
  end

  def decode_value(value, :kHangul, _fields) do
    case String.split(value, ":", trim: true) do
      [grapheme] -> %{grapheme: grapheme, source: nil}
      [grapheme, source] -> %{grapheme: grapheme, source: source}
    end
  end

  def decode_value(value, :kHanYu, _fields) do
    value
  end

  def decode_value(value, :kHanyuPinlu, _fields) do
    value
  end

  def decode_value(value, :kHanyuPinyin, _fields) do
    value
  end

  def decode_value(value, :kHDZRadBreak, _fields) do
    value
  end

  def decode_value(value, :kHKGlyph, _fields) do
    value
  end

  def decode_value(value, :kHKSCS, _fields) do
    value
  end

  def decode_value(value, :kIBMJapan, _fields) do
    value
  end

  def decode_value(value, :kIICore, _fields) do
    value
  end

  def decode_value(value, :kIRG_GSource, _fields) do
    value
  end

  def decode_value(value, :kIRG_HSource, _fields) do
    value
  end

  def decode_value(value, :kIRG_JSource, _fields) do
    value
  end

  def decode_value(value, :kIRG_KPSource, _fields) do
    value
  end

  def decode_value(value, :kIRG_KSource, _fields) do
    value
  end

  def decode_value(value, :kIRG_MSource, _fields) do
    value
  end

  def decode_value(value, :kIRG_SSource, _fields) do
    value
  end

  def decode_value(value, :kIRG_TSource, _fields) do
    value
  end

  def decode_value(value, :kIRG_UKSource, _fields) do
    value
  end

  def decode_value(value, :kIRG_USource, _fields) do
    value
  end

  def decode_value(value, :kIRG_VSource, _fields) do
    value
  end

  def decode_value(value, :kIRGDaeJaweon, _fields) do
    value
  end

  def decode_value(value, :kIRGDaiKanwaZiten, _fields) do
    value
  end

  def decode_value(value, :kIRGHanyuDaZidian, _fields) do
    value
  end

  def decode_value(value, :kIRGKangXi, _fields) do
    value
  end

  def decode_value(value, :kJa, _fields) do
    value
  end

  def decode_value(value, :kJapaneseKun, _fields) do
    value
  end

  def decode_value(value, :kJapaneseOn, _fields) do
    value
  end

  def decode_value(value, :kJinmeiyoKanji, _fields) do
    value
  end

  def decode_value(value, :kJis0, _fields) do
    value
  end

  def decode_value(value, :kJis1, _fields) do
    value
  end

  def decode_value(value, :kJIS0213, _fields) do
    value
  end

  def decode_value(value, :kJoyoKanji, _fields) do
    value
  end

  def decode_value(value, :kKangXi, _fields) do
    value
  end

  def decode_value(value, :kKarlgren, _fields) do
    value
  end

  def decode_value(value, :kKorean, _fields) do
    value
  end

  def decode_value(value, :kKoreanEducationHanja, _fields) do
    value
  end

  def decode_value(value, :kKoreanName, _fields) do
    value
  end

  def decode_value(value, :kKPS0, _fields) do
    value
  end

  def decode_value(value, :kKPS1, _fields) do
    value
  end

  def decode_value(value, :kKSC0, _fields) do
    value
  end

  def decode_value(value, :kKSC1, _fields) do
    value
  end

  def decode_value(value, :kLau, _fields) do
    value
  end

  def decode_value(value, :kMainlandTelegraph, _fields) do
    value
  end

  def decode_value(value, :kMandarin, _fields) do
    value
  end

  def decode_value(value, :kMatthews, _fields) do
    value
  end

  def decode_value(value, :kMeyerWempe, _fields) do
    value
  end

  def decode_value(value, :kMorohashi, _fields) do
    value
  end

  def decode_value(value, :kNelson, _fields) do
    value
  end

  def decode_value(value, :kOtherNumeric, _fields) do
    value
  end

  def decode_value(value, :kPhonetic, _fields) do
    value
  end

  def decode_value(value, :kPrimaryNumeric, _fields) do
    value
  end

  def decode_value(value, :kPseudoGB1, _fields) do
    value
  end

  def decode_value(value, :kRSAdobe_Japan1_6, _fields) do
    value
  end

  def decode_value(value, :kRSKangXi, _fields) do
    value
  end

  def decode_value(value, :kRSUnicode, _fields) do
    value
  end

  def decode_value(value, :kSBGY, _fields) do
    value
  end

  def decode_value(value, :kSemanticVariant, _fields) do
    value
  end

  def decode_value(value, :kSimplifiedVariant, _fields) do
    decode_codepoint(value)
  end

  def decode_value(value, :kSpecializedSemanticVariant, _fields) do
    value
  end

  def decode_value(value, :kSpoofingVariant, _fields) do
    value
  end

  def decode_value(value, :kStrange, _fields) do
    value
  end

  def decode_value(value, :kTaiwanTelegraph, _fields) do
    value
  end

  def decode_value(value, :kTang, _fields) do
    value
  end

  def decode_value(value, :kTGH, _fields) do
    value
  end

  def decode_value(value, :kTGHZ2013, _fields) do
    value
  end

  def decode_value(value, :kTotalStrokes, _fields) do
    value
  end

  def decode_value(value, :kTraditionalVariant, _fields) do
    decode_codepoint(value)
  end

  def decode_value(value, :kUnihanCore2020, _fields) do
    value
  end

  def decode_value(value, :kVietnamese, _fields) do
    value
  end

  def decode_value(value, :kXerox, _fields) do
    value
  end

  def decode_value(value, :kXHC1983, _fields) do
    value
  end

  def decode_value(value, :kZVariant, _fields) do
    value
  end

  # The default decoding is to do nothing.

  def decode_value(value, _key, _fields) do
    value
  end

  # Decodes a standard `U+xxxx` codepoing into
  # its integer form.

  defp decode_codepoint("U+" <> codepoint) do
    String.to_integer(codepoint, 16)
  end

  defp normalize_atom(category) do
    category
    |> String.downcase()
    |> String.replace(" ", "_")
    |> String.to_atom()
  end
end
