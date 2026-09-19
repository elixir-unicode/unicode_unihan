# Dictionary-like data

## kAlternateTotalStrokes
### Description
> The total number of strokes in the ideograph (including the radical). Each value consists either of a decimal value followed by an IRG source specifier as defined in Section 3.10, or of the special value “-” (U+002D-HYPHEN-MINUS).

> The IRG source specifier indicates the IRG sources for which a particular value is preferred.

> The stroke count value is the one for the representative glyph as shown in the code charts.

> Multiple stroke counts are listed in increasing numeric order. Stroke counts may not be repeated.

> The IRG sources sharing the kTotalStrokes value should not be explicitly listed. If all IRG sources share the kTotalStrokes value, then the value of “-” is used. The kAlternateTotalStrokes value for U+4E95 井 is therefore “-” instead of “4:GHJKPTV.”

> For IRG sources which do not include a source reference, the kAlternateTotalStrokes property should not have a corresponding value.

> Unlike the kTotalStrokes property, the data in this property is not to be taken as exhaustive. Where it is defined for an ideograph, however, it includes explicit or implicit values for all IRG sources containing the deograph.

### Shape of return

### Notes

## kCangjie
### Description
> The cangjie input code for the ideograph. This incorporates data from the file cangjie-table.b5 by Christian Wittern.

### Shape of return

### Notes

## kCheungBauer
### Description
> Data regarding the ideograph in Cheung Kwan-hin and Robert S. Bauer, The Representation of Cantonese with Chinese Characters, Journal of Chinese Linguistics, Monograph Series Number 18, 2002. Each data value consists of three pieces, separated by semicolons: (1) the ideograph’s radical-stroke index as a three-digit radical, slash, two-digit stroke count; (2) the ideograph’s cangjie input code (if any); and (3) a comma-separated list of Cantonese readings using the jyutping romanization in alphabetical order.

### Shape of return

### Notes

## kFenn
### Description
> Data on the ideograph from The Five Thousand Dictionary by Courtenay H. Fenn, Cambridge, Mass.: Harvard University Press, 1979.

> The data here consists of a decimal number followed by a letter A through K, the letter P, or an asterisk. The decimal number gives the Soothill number for the ideograph’s phonetic, and the letter is a rough frequency indication, with A indicating the 500 most common ideographs, B the next five hundred, and so on.

> P is used by Fenn to indicate a rare ideograph included in the dictionary only because it is the phonetic element in other ideographs.

> An asterisk is used instead of a letter in the final position to indicate an ideograph which belongs to one of Soothill’s phonetic groups but is not found in Fenn’s dictionary.

> Ideographs which have a frequency letter but no Soothill phonetic group are assigned group 0.

### Shape of return

### Notes

## kFourCornerCode
### Description
> The four-corner code(s) for the ideograph. This data is derived from data provided in the public domain by Hartmut Bohn, Urs App, and Christian Wittern. Additional property values were provided by Jaemin Chung.

> The four-corner system assigns each ideograph a four-digit code from 0 through 9. The digit is derived from the “shape” of the four corners of the ideograph (upper-left, upper-right, lower-left, lower-right). An optional fifth digit can be used to further distinguish ideographs; the fifth digit is derived from the shape in the region immediately above the  fourth corner.

> The four-corner system is now used only rarely for IMEs. It continues to be used, however, primarily for indexing and lookup in, for example, academic studies and reference material, especially in some Chinese dictionaries.

> Values in this property consist of four decimal digits, optionally followed by a period and fifth digit for a five-digit form.

### Shape of return

### Notes

## kGradeLevel
### Description
> The primary grade in the Hong Kong school system by which a student is expected to know the ideograph; this data is derived from 朗文初級中文詞典, Hong Kong: Longman, 2001.

### Shape of return

### Notes

## kHDZRadBreak
### Description
> Indicates that 《漢語大字典》 Hanyu Da Zidian has a radical break beginning at this ideograph’s position. The property value consists of the radical (with its Unicode code point), a colon, and then the Hanyu Da Zidian position as in the kHanyu property.

### Shape of return

### Notes

## kHKGlyph
### Description
> The index of the ideograph in 常用字字形表 (二零零零年修訂本),香港: 香港教育學院, 2000, ISBN 962-949-040-4. This publication gives the “proper” shapes for 4759 ideographs as used in the Hong Kong school system. The index is an integer, zero-padded to four digits.

### Shape of return

### Notes

## kMojiJoho
### Description
> This property provides mappings from CJK Unified Ideographs, along with SVSes (Standardized Variation Sequences) and registered Moji_Joho IVSes (Ideographic Variation Sequences) that use the CJK Unified Ideograph as a BC (Base Character), to Moji Jōhō Kiban database (文字情報基盤データベース) serial numbers. The property is based on Version 006.01 of the Moji Jōhō Kiban database. See MJ文字情報一覧表.

> If a colon (:) and VS (Variation Selector) follow a Moji Jōhō Kiban   database serial number, the sequence of the CJK Unified Ideograph,   serving as a BC, followed by the VS, corresponds to the Moji Jōhō   Kiban database serial number. Such sequences are SVSes or Moji_Joho   IVSes.

> If a Moji Jōhō Kiban database serial number appears both by   itself and followed by a colon and VS, the registered   Moji_Joho IVS that corresponds to the latter is considered the   default (that is, encoded) form.

> The Moji Jōhō Kiban database and its mappings are owned by   CITPC (Character Information Technology Promotion Council   文字情報技術促進協議会), and are used under license.

### Shape of return

```elixir
%{id: "MJ000005"}
%{id: "MJ000005", variation_selector: 917761}
```

`:variation_selector` is present, as an integer code point, when the serial number applies to a variation sequence rather than the base ideograph. Multiple entries are returned as a list.

### Notes

## kPhonetic
### Description
> The phonetic class for the ideograph, as adopted   from Ten Thousand Characters: An Analytic Dictionary,   by G. Hugh Casey, S.J. Hong Kong: Kelly and Walsh, 1980.

> Ideographs in the same phonetic class have a common phonetic element, such as U+8015 耕 and U+9631 阱, both assigned to the phonetic class 103. Most classes have a prototype ideograph, which serves as the common phonetic element for the remaining members of the class. For example, U+4E4D 乍 is the prototype for ideographs of class 10.

> Some classes are associated with one to four subsidiary classes, indicated by the letters A through D.

> Some ideographs are assigned multiple classes. This can happen, for example, when an ideograph belongs to one class but is also the prototype for a different class. For example, U+570B 國 is the prototype for class 748, but is also a member of class 1416, which has U+6216 或 as its prototype. Its kPhonetic value is therefore “748 1416.”

> Multiple values are always in ascending numerical order.

> An asterisk is appended when an ideograph has the given phonetic class but is not explicitly included in the ideograph list for that class. For example, U+8753 蝓 belongs to the class 1611 but is not explicitly listed in that class. Its kPhonetic value is therefore “1611*.”

> The Chinese Phonetic Groups page is a useful resource for browsing the kPhonetic property data.

### Shape of return

### Notes

## kStrange
### Description
> This property identifies CJK Unified Ideographs that are considered “strange” in one or more ways per the following 12 categories:

> Category A = [A]symmetric (exhibits a structure that is asymmetric)

> Category B = [B]opomofo (visually resembles a bopomofo character)

> Category C = [C]ursive (is cursive or includes one or more cursive components that do not adhere to Han ideograph stroke conventions)

> Category H = [H]angul Component (includes one or more hangul components)

> Category I = [I]ncomplete (appears to be an incomplete version of an existing or possible ideograph, meaning that one or more components appear to be incomplete, without regard to semantics)

> Category K = [K]atakana Component (includes one or more components that visually resemble a katakana syllable)

> Category M = [M]irrored (is either mirrored or includes one or more components that are mirrored)

> Category O = [O]dd Component (includes one or more components that are symbol-like or are otherwise considered odd)

> Category R = [R]otated (is either rotated or includes one or more components that are rotated)

> Category S = [S]troke-heavy (has 40 or more strokes)

> Category U = [U]nusual Arrangment/Structure (has an unusual structure or component arrangement)

> Category Y = S[Y]mmetric (is symmetric, or includes components that are symmetric, meaning that the mirrored and unmirrored components are arranged side-by-side or stacked top-and-bottom)

> This property is fully documented in Unicode Technical Note #43, “Unihan Database Property ‘kStrange’” [UTN43].

### Shape of return

Each entry is a map with a `:category` of `:asymmetric`, `:bopomofo`, `:cursive`, `:hangul`, `:incomplete`, `:katakana`, `:mirrored`, `:odd`, `:rotated`, `:stroke_heavy`, `:symmetric` or `:unusual`.

```elixir
%{category: :mirrored, codepoints: [19968]}
%{category: :bopomofo, codepoint: 12549}
%{category: :stroke_heavy, strokes: 48}
```

Category B carries the resembled bopomofo character under `:codepoint`; categories H, I, K, M, O, R and Y carry any related code points under `:codepoints`; category S carries the stroke count under `:strokes`. Multiple categories are returned as a list.

### Notes

## kUnihanCore2020
### Description
> Used for ideographs which are in the Unihan Core 2020 set, the minimal set of required ideographs for East Asia.   An ideograph is in the Unihan Core 2020 set if and only if it has a value for the kUnihanCore2020 property.

> The property value consists of an IRG source specifier as defined in     Section 3.10 above.

### Shape of return

### Notes
