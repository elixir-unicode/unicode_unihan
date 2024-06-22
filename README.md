# Unicode Unihan

[![Hex Version](https://img.shields.io/hexpm/v/unicode_unihan.svg)](https://hex.pm/packages/unicode_unihan)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/unicode_unihan/)
[![Download/Week](https://img.shields.io/hexpm/dw/unicode_unihan.svg?)](https://hex.pm/packages/unicode_unihan)
[![License](https://img.shields.io/hexpm/l/unicode_unihan.svg)](https://hex.pm/packages/unicode_unihan)
[![Last Updated](https://img.shields.io/github/last-commit/elixir-unicode/unicode_unihan.svg)](https://github.com/elixir-unicode/unicode_unihan/commits/master)

Functions to return information about Unicode Unihan codepoints.

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
  kTang: %{frequent: true, reading: "miæ̀n"},
  kSBGY: %{position: 37, page: 397},
  kCantonese: %{
    final: "aan",
    jyutping: "maan6",
    coda: "n",
    nucleus: "aa",
    onset: "m",
    tone: "6"
  },
  kCihaiT: %{position: 2, page: 1149, row: 4},
  kTotalStrokes: %{Hans: 12, Hant: 12},
  kXerox: "242:161",
  kSimplifiedVariant: 19975,
  kJapanese: ["バン", "マン", "よろず"],
  kIICore: %{priority: "A", irg: ["T", "J", "H", "K", "M", "P"]},
  kIRG_JSource: %{source: "J0", mapping: "685F"},
  kCNS1992: "1-655C",
  kCNS1986: "1-655C",
  kIRG_VSource: %{source: "V1", mapping: "6538"},
  kKorean: "MAN",
  kCowles: 2576,
  kHangul: %{source: "0E", grapheme: "만"},
  kFenn: %{fenn_phonetic: 576, importance: "C"},
  kNelson: 3984,
  kRSAdobe_Japan1_6: %{
    code: "C",
    cid: 6408,
    kangxi: 140,
    strokes_radical: 3,
    strokes_residue: 9
  },
  kCangjie: ["T", "W", "L", "B"],
  kVietnamese: "vạn",
  kFourCornerCode: %{
    upper_left: 4,
    upper_right: 4,
    lower_left: 4,
    lower_right: 2,
    center: 7
  },
  kSMSZD2003Readings: "wàn粵maan6",
  kKangXi: %{position: 33, virtual: false, page: 1042},
  kIRG_KSource: %{source: "K0", mapping: "583F"},
  kGSR: %{index: 267, letter: "a", prime: ""},
  kMandarin: "wàn",
  kCCCII: "214F22",
  kXHC1983: %{position: 4, entry: 1, page: 1185, reading: "wàn"},
  kJinmeiyoKanji: %{year: 2010, codepoint: 19975},
  kFennIndex: %{position: 3, page: 593},
  kHanyuPinyin: %{
    location: [%{position: 8, virtual: false, page: 53247}],
    readings: ["wàn"]
  },
  kHanYu: %{position: 8, virtual: false, page: 3247, volume: 5},
  kHanyuPinlu: %{reading: "wàn", frequency: 1335},
  kDefinition: ["ten thousand", " innumerable"],
  kIRGDaeJaweon: %{position: 6, virtual: false, page: 1501},
  kIRG_HSource: %{source: "HB1", mapping: "B855"},
  kBigFive: {47189, ""},
  kPrimaryNumeric: 10000,
  kMatthews: %{index: 7030, trailing: ""},
  kMorohashi: %{index: 31339, prime: ""},
  codepoint: 33836,
  kIRG_GSource: %{source: "G1", mapping: ["4D72"]},
  kIRG_KPSource: %{source: "KP0", mapping: "DAC6"},
  kDaeJaweon: %{position: 6, virtual: false, page: 1501},
  kGradeLevel: 4,
  kTaiwanTelegraph: 5502,
  kEACC: 2182946,
  kMojiJoho: ["MJ022254", ...],
  kSemanticVariant: [...],
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
