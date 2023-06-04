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
    {:unicode_unihan, "~> 0.1"}
  ]
end
```

## Usages

(Optional) Download and update the latest Unihan database:

```bash
mix unicode.unihan.download
```

Lookup a character by codespoint in IEx:

```elixir
import Unicode.Unihan
unihan(33836)
```

```elixir
Loading the Unihan database.
%{
  kTotalStrokes: %{Hans: 12, Hant: 12},
  kRSAdobe_Japan1_6: %{
    code: "C",
    cid: 6408,
    kangxi: 140,
    strokes_radical: 3,
    strokes_residue: 9
  },
  kMorohashi: %{index: 31339, prime: ""},
  kFennIndex: %{position: 3, page: 593},
  kDaeJaweon: %{position: 6, virtual: false, page: 1501},
  kRSUnicode: %{strokes: 8, radical: 114, simplified_radical: false},
  kSBGY: %{position: 37, page: 397},
  kIRG_JSource: %{source: "J0", mapping: "685F"},
  kGB1: 4582,
  kTaiwanTelegraph: 5502,
  kKangXi: %{position: 33, virtual: false, page: 1042},
  kJapaneseKun: ["YOROZU", "OOKII"],
  kXHC1983: %{position: 4, entry: 1, page: 1185, reading: "wàn"},
  kVietnamese: "vạn",
  kIRG_TSource: %{source: "T1", mapping: "655C"},
  kIRGKangXi: %{position: 33, virtual: false, page: 1042},
  kSemanticVariant: [
    %{sources: ["kLau", "kMatthews", "kMeyerWempe"], codepoint: 19975},
    %{sources: ["kFenn"], codepoint: 21325}
  ],
  kMeyerWempe: %{index: 1744, letter: ""},
  kFourCornerCode: %{
    upper_left: 4,
    upper_right: 4,
    lower_left: 4,
    lower_right: 2,
    center: 7
  },
  kIRGHanyuDaZidian: %{position: 8, virtual: false, page: 3247, volume: 5},
  kIRG_KSource: %{source: "K0", mapping: "583F"},
  kFrequency: 2,
  kIICore: %{priority: "A", irg: ["T", "J", "H", "K", "M", "P"]},
  kCNS1992: "1-655C",
  kCowles: 2576,
  kLau: 2058,
  kNelson: 3984,
  kJinmeiyoKanji: %{year: 2010, codepoint: 19975},
  kTang: %{frequent: true, reading: "miæ̀n"},
  kHKGlyph: 2889,
  kGradeLevel: 4,
  kIRGDaiKanwaZiten: %{index: 31339, prime: ""},
  kCihaiT: %{position: 2, page: 1149, row: 4},
  kKoreanEducationHanja: 2007,
  codepoint: 33836,
  kDefinition: ["ten thousand", " innumerable"],
  kHanyuPinyin: %{
    location: [%{position: 8, virtual: false, page: 53247}],
    readings: ["wàn"]
  },
  kBigFive: 47189,
  kMatthews: %{index: 7030, trailing: ""},
  kCangjie: ["T", "W", "L", "B"],
  kMandarin: "wàn",
  kKSC0: 5631,
  kEACC: 2182946,
  kKorean: "MAN",
  kKPS0: "DAC6",
  kIRG_KPSource: %{source: "KP0", mapping: "DAC6"},
  kAccountingNumeric: 10000,
  kIRG_GSource: %{source: "G1", mapping: ["4D72"]},
  kGSR: %{index: 267, letter: "a", prime: ""},
  kUnihanCore2020: ["H", "J", "K", "M", "P", "T"],
  kHangul: %{source: "0E", grapheme: "만"},
  kJapaneseOn: "MAN",
  kFenn: %{fenn_phonetic: 576, importance: "C"},
  kPhonetic: %{class: 866},
  kCantonese: %{
    final: "aan",
    jyutping: "maan6",
    coda: "n",
    nucleus: "aa",
    onset: "m",
    tone: "6"
  },
  kJis0: "7263",
  kCNS1986: "1-655C",
  kRSKangXi: %{strokes: 9, radical: 140},
  kIRG_VSource: %{source: "V1", mapping: "6538"},
  kCCCII: "214F22",
  kSimplifiedVariant: 19975,
  kXerox: "242:161",
  kIRGDaeJaweon: %{position: 6, virtual: false, page: 1501},
  kIRG_HSource: %{source: "HB1", mapping: "B855"},
  kHanyuPinlu: %{reading: "wàn", frequency: 1335},
  kHanYu: %{position: 8, virtual: false, page: 3247, volume: 5}
}
```

For more details, see the [guide to Unihan and Unihan introspection](https://raw.githubusercontent.com/elixir-unicode/unicode_unihan/main/docs/unihan_walkthrough.livemd) Livebook, or:

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fraw.githubusercontent.com%2Felixir-unicode%2Funicode_unihan%2Fmain%2Fdocs%2Funihan_walkthrough.livemd)

## Copyright and License

Copyright (c) 2023 Kip Cole ([@kipcole9](https://github.com/kipcole9)) & Jon Chui ([@jkwchui](https://github.com/jkwchui))

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in
compliance with the License. You may obtain a copy of the License at

> https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License
is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing permissions and limitations under the
License.

The Unihan Database data files in this repository are governed by the terms of
the [Unicode, Inc. License Agreement](https://www.unicode.org/license.html).
