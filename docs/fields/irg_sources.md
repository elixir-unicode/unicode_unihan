# IRG sources

## kCompatibilityVariant
### Description
> The canonical Decomposition_Mapping value for the ideograph, derived from UnicodeData.txt. This field is derived by taking the non-null Decomposition_Mapping values from Field 5 of UnicodeData.txt, for characters contained within the CJK Compatibility Ideographs block and the CJK Compatibility Ideographs Supplement block.

### Shape of return

### Notes

## kIICore
### Description
> Used for characters which are in IICore, the IRG-produced minimal set of required ideographs for East Asian use. A character is in IICore if and only if it has a value for the kIICore field.

> Each value consists of a letter (A, B, or C), indicating priority value, followed by an IRG source specifier as defined in Section 3.10 above.

### Shape of return

### Notes

## kIRG_GSource
### Description
> The IRG “G” source mapping for this character in hexadecimal or decimal. The IRG G source consists of data from the following national standards, publications, and lists from the People’s Republic of China and Singapore. The versions of the standards used are those provided by the PRC to the IRG and may not always reflect published versions of the standards generally available.

This is an abridged entry.  For what the G source standards are referring to, see the `kIRG_GSource` [entry](https://www.unicode.org/reports/tr38/#kIRG_GSource) in Annex #38.

### Shape of return

### Notes

## kIRG_HSource
### Description
> The IRG “H” source mapping for this character in hexadecimal. The IRG “H” source consists of data from the following sources:

> H Hong Kong Supplementary Character Set – 2008
> HB0 Big-5: Computer Chinese Glyph and Character Code Mapping Table, Technical Report C-26, 電腦用中文字型與字碼對照表, 技術通報C-26, 1984, Symbols
> HB1 Big-5, Level 1
> HB2 Big-5, Level 2
> HD Hong Kong Supplementary Character Set – 2016
> HU The source reference for this character has been moved; the value is its code point. 

### Shape of return

### Notes

## kIRG_JSource
### Description
> The IRG “J” source mapping for this character in hexadecimal or decimal. The IRG “J” source consists of data from the following national standards and lists from Japan.

This is an abridged entry.  See the `kIRG_JSource` [entry](https://www.unicode.org/reports/tr38/#kIRG_JSource) in Annex #38 for detailed list of what national standards are referred to by the acronyms.

### Shape of return

### Notes

## kIRG_KPSource
### Description
> The IRG “KP” source mapping for this character in hexadecimal. The IRG “KP” source consists of data from the following national standards and lists from the Democratic People’s Republic of Korea (North Korea).

> KP0 KPS 9566-97
> KP1 KPS 10721-2000
> KPU The source reference for this character has been moved; the value is its code point.

> It is currently not possible to communicate with standards bodies within the DPRK. There may, therefore, be erroneous data in the values for this field.

### Shape of return

### Notes

## kIRG_KSource
### Description
> The IRG “K” source mapping for this character in hexadecimal or decimal. The IRG “K” source consists of data from the following national standards and lists from the Republic of Korea (South Korea).

This is an abridged entry.  See the `kIRG_KSource` [entry](https://www.unicode.org/reports/tr38/#kIRG_KSource) in Annex #38 for detailed list of what national standards are referred to by the acronyms.

### Shape of return

### Notes

## kIRG_MSource
### Description
> The IRG “M” source mapping for this character in decimal. The IRG “M” source corresponds to MSCS (Macao Supplementary Character Set).

> MA HKSCS-2008 code point in hexadecimal
> MB Big Five code point in hexadecimal
> MC MSCS reference
> MD MSCS horizontal extensions

### Shape of return

### Notes

## kIRG_SSource
### Description
> The IRG “S” source mapping for this character that corresponds to Taishō Shinshū Daizōkyō (大正新脩大藏經), 1924–1934, which is accessible in the SAT Daizōkyō Text Database. The source references consist of “SAT” followed by a hyphen and five decimal digits, zero padded.

### Shape of return

### Notes

## kIRG_TSource
### Description
> The IRG “T” source mapping for this character in hexadecimal. The IRG “T” source consists of data from the following standards and lists. “TCA” stands for “Taipei Computer Association,” and “CNS” stands for “Chinese National Standard.”

This is an abridged entry.  See the `kIRG_TSource` [entry](https://www.unicode.org/reports/tr38/#kIRG_TSource) in Annex #38 for detailed list of what national standards are referred to by the acronyms.

### Shape of return

### Notes

## kIRG_UKSource
### Description
> The IRG “UK” source mapping for this character in decimal. The source references consist of “UK” followed by a hyphen and five decimal digits, zero padded. The IRG “UK” source currently consists of data from the documents IRG N2107R2 and IRG N2232R that are available in the [UK-source Ideographs repository](https://github.com/unicode-org/uk-source-ideographs/).

### Shape of return

### Notes

## kIRG_USource
### Description
> The IRG “U” source mapping for this character in decimal. U-source references are a reference into the U-source ideograph database; see [UAX45]. They consist of “UTC” followed by a hyphen and a five-digit, zero-padded index into the database.

### Shape of return

### Notes

## kIRG_VSource
### Description
> The IRG “V” source mapping for this character in hexadecimal. The IRG “V” source consists of data from the following national standards and lists from Vietnam.

> V0 TCVN 5773:1993
> V1 TCVN 6056:1995
> V2 VHN 01:1998
> V3 VHN 02: 1998
> V4 Kho Chữ Hán Nôm Mã Hoá (Hán Nôm Coded Character Repertoire), Hà Nội, 2007
> VN Vietnamese horizontal extensions; the value is its code point 

### Shape of return

### Notes

## kRSUnicode
### Description
> The standard radical-stroke count for this character in the form “radical.additional strokes”. The radical is indicated by a number in the range (1..214) inclusive. An apostrophe (') after the radical indicates a simplified version of the given radical. The “additional strokes” value is the residual stroke-count, the count of all strokes remaining after eliminating all strokes associated with the radical.

> This field is also used for additional radical-stroke indices where either a character may be reasonably classified under more than one radical, or alternate stroke count algorithms may provide different stroke counts.

> The residual stroke count may be negative. This is because some characters (for example, U+225A9, U+29C0A) are constructed by removing strokes from a standard radical.

### Shape of return

### Notes

## kTotalStrokes
### Description
> The total number of strokes in the character (including the radical). When there are two values, then the first is preferred for zh-Hans (CN) and the second is preferred for zh-Hant (TW). When there is only one value, it is appropriate for both.

> The preferred value is the one most commonly associated with the character in modern text using customary fonts.

> This field is targeted specifically for use by CLDR collation and transliteration. As such, it is subject to considerations that help keep pīnyīn-based Han collation (and its tailorings) and transliteration reasonably stable.

### Shape of return

### Notes
