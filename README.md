# Unicode Unihan

[![Hex Version](https://img.shields.io/hexpm/v/unicode_unihan.svg)](https://hex.pm/packages/unicode_unihan)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/unicode_unihan/)
[![Download/Week](https://img.shields.io/hexpm/dw/unicode_unihan.svg?)](https://hex.pm/packages/unicode_unihan)
[![License](https://img.shields.io/hexpm/l/unicode_unihan.svg)](https://hex.pm/packages/unicode_unihan)
[![Last Updated](https://img.shields.io/github/last-commit/elixir-unicode/unicode_unihan.svg)](https://github.com/elixir-unicode/unicode_unihan/commits/master)

Functions to return information about Unicode Unihan codepoints. This release ships the data of [Unicode 18.0](https://www.unicode.org/versions/Unicode18.0.0/), covering 103,000 CJK code points and 99 properties, and follows the property definitions of [UAX #38](https://www.unicode.org/reports/tr38/) revision 41.

## Installation

The package can be installed by adding `:unicode_unihan` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unicode_unihan, "~> 0.4"}
  ]
end
```

### Updating the Unihan database

Twice a year the Unicode consortium releases a new version of the Unicode database. This updated data can then be used in `unicode_unihan` by running the following mix task:

```bash
mix unicode.unihan.download
```

## Usage

Lookup a character by codespoint in IEx:

```elixir
iex> Unicode.Unihan.unihan(33836)
%{
  codepoint: 33836,
  kTotalStrokes: 13,
  kRSUnicode: [
    %{radical: 114, strokes: 8, script: :Hant, simplified_radical: false},
    %{radical: 140, strokes: 9, script: :Hant, simplified_radical: false}
  ],
  kCantonese: %{
    final: "aan",
    jyutping: "maan6",
    coda: "n",
    nucleus: "aa",
    onset: "m",
    tone: "6"
  },
  kMandarin: "wàn",
  kJapanese: ["バン", "マン", "よろず"],
  kJapaneseOn: "MAN",
  kJapaneseKun: ["YOROZU", "OOKII"],
  kKorean: "MAN",
  kHangul: %{source: "0E", grapheme: "만"},
  kVietnamese: "vạn",
  kFanqie: "無販",
  kTang: %{frequent: true, reading: "miæ̀n"},
  kDefinition: ["ten thousand", " innumerable"],
  kPrimaryNumeric: 10000,
  kGradeLevel: 4,
  kSimplifiedVariant: 19975,
  kJapaneseNewVariant: 19975,
  kSemanticVariant: [
    %{sources: ["kLau", "kMatthews", "kMeyerWempe"], codepoint: 19975},
    %{sources: ["kFenn"], codepoint: 21325}
  ],
  kCangjie: ["T", "W", "L", "B"],
  kFourCornerCode: %{
    upper_left: 4,
    upper_right: 4,
    lower_left: 4,
    lower_right: 2,
    center: 7
  },
  kKangXi: %{position: 33, virtual: false, page: 1042},
  kHanYu: %{position: 8, virtual: false, page: 3247, volume: 5},
  kHanyuPinyin: %{
    location: [%{position: 8, virtual: false, page: 53247}],
    readings: ["wàn"]
  },
  kMorohashi: %{index: 31339, prime: "", supplement: false, variation_selector: 917763},
  kMojiJoho: [
    %{id: "MJ022254"},
    %{id: "MJ022254", variation_selector: 917761},
    ...
  ],
  kSMSZD2003Index: %{page: 589, position: 5},
  kSMSZD2003Readings: %{mandarin: ["wàn"], cantonese: [%{jyutping: "maan6", ...}]},
  kIRG_GSource: %{source: "G1", mapping: ["4D72"]},
  kIRG_JSource: %{source: "J0", mapping: "685F"},
  kIRG_KSource: %{source: "K0", mapping: "583F"},
  kIRG_TSource: %{source: "T1", mapping: "655C"},
  kIICore: %{priority: "A", irg: ["T", "J", "H", "K", "M", "P"]},
  kUnihanCore2020: ["H", "J", "K", "M", "P", "T"],
  kBigFive: {47189, ""},
  kCNS1986: "1-655C",
  kEACC: 2182946,
  kTaiwanTelegraph: 5502,
  ...
}
```

For more details, see the [guide to Unihan and Unihan introspection](https://raw.githubusercontent.com/elixir-unicode/unicode_unihan/main/docs/unihan_walkthrough.livemd) Livebook, or:

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fraw.githubusercontent.com%2Felixir-unicode%2Funicode_unihan%2Fmain%2Fdocs%2Funihan_walkthrough.livemd)

## Copyright and License

Copyright (c) 2023-2024 Kip Cole ([@kipcole9](https://github.com/kipcole9)) & Jon Chui ([@jkwchui](https://github.com/jkwchui))

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in
compliance with the License. You may obtain a copy of the License at

> https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License
is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing permissions and limitations under the
License.

The Unihan Database data files in this repository are governed by the terms of
the [Unicode, Inc. License Agreement](https://www.unicode.org/license.html).
