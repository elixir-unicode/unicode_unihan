# Dictionary-like data

## kAlternateTotalStrokes
### Description
> The total number of strokes in the character (including the radical). Each value consists either of a decimal value followed by an IRG source specifier as defined in Section 3.10, or of the special value “-”.

> The IRG source specifier indicates the IRG sources for which a particular value is preferred. The source identifiers “G” and “T” are not used in this field, as these IRG sources are fully covered by the kTotalStrokes field.

> The stroke count value is the one for the glyph as shown in the code charts.

> Multiple stroke counts are listed in increasing numeric order. Stroke counts may not be repeated.

This is an abridged entry.  For examples and details, see [its entry](https://www.unicode.org/reports/tr38/#kAlternateTotalStrokes) in Annex #38.

### Shape of return

### Notes

## kCangjie
### Description
> The cangjie input code for the character. This incorporates data from the file cangjie-table.b5 by Christian Wittern.

### Shape of return

### Notes

## kCheungBauer
### Description
> Data regarding the character in Cheung Kwan-hin and Robert S. Bauer, The Representation of Cantonese with Chinese Characters, Journal of Chinese Linguistics, Monograph Series Number 18, 2002. Each data value consists of three pieces, separated by semicolons: (1) the character’s radical-stroke index as a three-digit radical, slash, two-digit stroke count; (2) the character’s cangjie input code (if any); and (3) a comma-separated list of Cantonese readings using the jyutping romanization in alphabetical order.

### Shape of return

### Notes

## kFenn
### Description
> Data on the character from The Five Thousand Dictionary by Courtenay H. Fenn, Cambridge, Mass.: Harvard University Press, 1979.

> The data here consists of a decimal number followed by a letter A through K, the letter P, or an asterisk. The decimal number gives the Soothill number for the character’s phonetic, and the letter is a rough frequency indication, with A indicating the 500 most common ideographs, B the next five hundred, and so on.

> P is used by Fenn to indicate a rare character included in the dictionary only because it is the phonetic element in other characters.

> An asterisk is used instead of a letter in the final position to indicate a character which belongs to one of Soothill’s phonetic groups but is not found in Fenn’s dictionary.

> Characters which have a frequency letter but no Soothill phonetic group are assigned group 0.

### Shape of return

### Notes

## kFourCornerCode
### Description
> The four-corner code(s) for the character. This data is derived from data provided in the public domain by Hartmut Bohn, Urs App, and Christian Wittern.

> The four-corner system assigns each character a four-digit code from 0 through 9. The digit is derived from the “shape” of the four corners of the character (upper-left, upper-right, lower-left, lower-right). An optional fifth digit can be used to further distinguish characters; the fifth digit is derived from the shape in the character’s center or region immediately to the left of the fourth corner.

> The four-corner system is now used only rarely. Full descriptions are available online, for example, at http://en.wikipedia.org/wiki/Four_corner_input.

> Values in this field consist of four decimal digits, optionally followed by a period and fifth digit for a five-digit form.

### Shape of return

### Notes

## kFrequency
### Description
> A rough frequency measurement for the character based on analysis of traditional Chinese USENET postings; characters with a kFrequency of 1 are the most common, those with a kFrequency of 2 are less common, and so on, through a kFrequency of 5.

### Shape of return

### Notes

## kGradeLevel
### Description
> The primary grade in the Hong Kong school system by which a student is expected to know the character; this data is derived from 朗文初級中文詞典, Hong Kong: Longman, 2001.

### Shape of return

### Notes

## kHDZRadBreak
### Description
> Indicates that 《漢語大字典》 Hanyu Da Zidian has a radical break beginning at this character’s position. The field consists of the radical (with its Unicode code point), a colon, and then the Hanyu Da Zidian position as in the kHanyu field.

### Shape of return

### Notes

## kHKGlyph
### Description
> The index of the character in 常用字字形表 (二零零零年修訂本),香港: 香港教育學院, 2000, ISBN 962-949-040-4. This publication gives the “proper” shapes for 4759 characters as used in the Hong Kong school system. The index is an integer, zero-padded to four digits.

### Shape of return

### Notes

## kPhonetic
### Description
> The phonetic class for the character, as adopted from Ten Thousand Characters: An Analytic Dictionary, by G. Hugh Casey, S.J. Hong Kong: Kelly and Walsh, 1980.

> Characters in the same phonetic class have a common phonetic element, such as 耕 (U+8015) and 阱 (U+9631), both assigned to the phonetic class 103. Most classes have a prototype character, which serves as the common phonetic element for the remaining members of the class. For example, 乍 (U+4E4D) is the prototype for characters of class 10.

> Some classes are associated with one to four subsidiary classes, indicated by the letters A through D.

> Some characters are assigned multiple classes. This can happen, for example, when a character belongs to one class but is also the prototype for a different class. For example, 國 (U+570B) is the prototype for class 748, but is also a member of class 1416, which has 或 (U+6216) as its prototype. Its kPhonetic value is therefore "748 1416."

> Multiple values are always in ascending numerical order.

> An asterisk is appended when a character has the given phonetic class but is not explicitly included in the character list for that class. For example, 蝓 (U+8753) belongs to the class 1611 but is not explicitly listed in that class. Its kPhonetic value is therefore "1611*".

> Casey includes a radical-stroke index mapping characters to their phonetic class. In some cases, this mapping is in error; when this happens, a lowercase "x" is appended to the index. For example, 萑 (U+8411) is assigned to the classes 216 and 285, but the assignment to class 216 is clearly in error. Its kPhonetic value is therefore "216x 285". 

### Shape of return

### Notes

## kStrange
### Description
> This property identifies CJK Unified Ideographs that are considered "strange" in one or more ways per the following 12 categories:

> Category A = [A]symmetric (exhibits a structure that is asymmetric)
> Category B = [B]opomofo (visually resembles a bopomofo character)
> Category C = [C]ursive (is cursive or includes one or more cursive components that do not adhere to Han ideograph stroke conventions)
> Category F = [F]ully-reflective (is fully-reflective or includes components that are fully-reflective, meaning that the mirrored and unmirrored components are arranged side-by-side or stacked top-and-bottom)
> Category H = [H]angul Component (includes a hangul component)
> Category I = [I]ncomplete (appears to be an incomplete version of an existing or possible ideograph, meaning that one or more components appear to be incomplete, without regard to semantics)
> Category K = [K]atakana Component (includes one or more components that visually resemble a katakana syllable)
> Category M = [M]irrored (is either mirrored or includes one or more components that are mirrored)
> Category O = [O]dd Component (includes one or more components that are symbol-like or are otherwise considered odd)
> Category R = [R]otated (is either rotated or includes one or more components that are rotated)
> Category S = [S]troke-heavy (has 40 or more strokes)
> Category U = [U]nusual Arrangement/Structure (has an unusual structure or component arrangement)

> This property is fully documented in [UTN43](https://www.unicode.org/notes/tn43/), Unihan Database Property “kStrange”.

### Shape of return

### Notes

## kUnihanCore2020
### Description
> Used for characters which are in the UnihanCore2020 set, the minimal set of required ideographs for East Asia. A character is in the UnihanCore2020 set if and only if it has a value for the kUnihanCore2020 property.

### Shape of return

### Notes
