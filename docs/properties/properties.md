# Unihan Properties

The Unihan database provides detailed descriptions for each CJK ideograph.  These descriptions (*properties*) are plain text, and can themselves be grouped into categories.

Properties in Unihan, for historical reasons, have names that begins with `k`.  Examples include `kGradeLevel`, `kKangXi`, and `kStrange`.  The string in each field can contain a single entry, or a list of entries separated by a delimiter; each entry is encoded in a special format according to the needs of the field.  For example, `kKangXi` describes where to find the ideograph in the 《康熙字典》Kangxi Dictionary, and a typical entry may be "1187.061".  The user is expected to consult the Unihan specifications to interpret this as page 1187, position 6, and virtual (the trailing 1 indicates that the ideograph is *not* actually in the dictionary).

The `Unicode.Unihan` module simplifies access by parsing these into sensible structures.  Each character is represented as a map, with atom keys (e.g., `:kKangXi`) used to access properties.  Where multiple entries exists inside a property, they are split into a list; each entry is parsed into a map.  The example entry above would be structured to:

```elixir
%{
    page: 1187,
    position: 6,
    virtual: true
}
```

The contents of entries are cast into appropriate types (for example, integer for `page`).  This facilitates access using the `filter/1` and `reject/1` functions: you can now isolate all characters in KangXi Dictionary between pages 1100--1200, or all the virtual characters; since `filter/1` and `reject/1` accept arbitrary functions, you can even combine properties and compose a query for "virtual characters in KangXi that are *also* grade-level 3 or below".

In the accompanying pages, we describe in some detail what the properties are and how entries were parsed.  These are grouped thematically as follows:

* [Dictionary Indices](properties/dictionary_indices.md): kCheungBauerIndex, kCihaiT, kCowles, kDaeJaweon, kFennIndex, kGSR, kHanYu, kIRGHanyuDaZidian, kKangXi, kKarlgren, kLau, kMatthews, kMeyerWempe, kMorohashi, kNelson, kSBGY, kSMSZD2003Index

* [Dictionary-like data](properties/dictionary_like_data.md): kAlternateTotalStrokes, kCangjie, kCheungBauer, kFenn, kFourCornerCode, kGradeLevel, kHDZRadBreak, kHKGlyph, kMojiJoho, kPhonetic, kStrange, kUnihanCore2020

* [IRG sources](properties/irg_sources.md): kCompatibilityVariant, kIICore, kIRG_GSource, kIRG_HSource, kIRG_JSource, kIRG_KPSource, kIRG_KSource, kIRG_MSource, kIRG_SSource, kIRG_TSource, kIRG_UKSource, kIRG_USource, kIRG_VSource, kRSUnicode, kTotalStrokes

* [Numeric values](properties/numeric_values.md): kAccountingNumeric, kOtherNumeric, kPrimaryNumeric, kTayNumeric, kVietnameseNumeric, kZhuangNumeric

* [Other mappings](properties/other_mappings.md): kBigFive, kCCCII, kCNS1986, kCNS1992, kEACC, kGB0, kGB1, kGB3, kGB5, kGB8, kIBMJapan, kJinmeiyoKanji, kJis0, kJIS0213, kJis1, kJoyoKanji, kKoreanEducationHanja, kKoreanName, kMainlandTelegraph, kPseudoGB1, kTaiwanTelegraph, kTGH, kXerox

* [Radical Stroke Counts](properties/radical_stroke_counts.md): kRSAdobe_Japan1_6

* [Readings](properties/readings.md): kCantonese, kDefinition, kFanqie, kHangul, kHanyuPinlu, kHanyuPinyin, kJapanese, kJapaneseKun, kJapaneseOn, kKorean, kMandarin, kSMSZD2003Readings, kTang, kTGHZ2013, kVietnamese, kXHC1983, kZhuang

* [Variants](properties/variants.md): kJapaneseNewVariant, kJapaneseOldVariant, kSemanticVariant, kSimplifiedVariant, kSpecializedSemanticVariant, kSpoofingVariant, kTraditionalVariant, kZVariant
