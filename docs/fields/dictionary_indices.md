# Dictionary Indices

## kCheungBauerIndex
### Description
> The position of the character in Cheung Kwan-hin and Robert S. Bauer, The Representation of Cantonese with Chinese Characters, Journal of Chinese Linguistics, Monograph Series Number 18, 2002. The format is a three-digit page number followed by a two-digit position number, separated by a period.

### Shape of return

### Notes

## kCihaiT
### Description
> The position of this character in the Cihai (辭海) dictionary, single volume edition, published in Hong Kong by the Zhonghua Bookstore, 1983 (reprint of the 1947 edition), ISBN 962-231-005-2.  The position is indicated by a decimal number. The digits to the left of the decimal are the page number. The first digit after the decimal is the row on the page, and the remaining two digits after the decimal are the position on the row.

### Shape of return

### Notes

## kCowles
### Description
>  	The index or indices of this character in Roy T. Cowles, A Pocket Dictionary of Cantonese, Hong Kong: University Press, 1999.  The Cowles indices are numerical, usually integers but occasionally fractional where a character was added after the original indices were determined. 

> Cowles is missing indices 1222 and 4949, and four characters in Cowles are part of Unicode’s “Hangzhou” numeral set: 2964 (U+3025), 3197 (U+3028), 3574 (U+3023), and 4720 (U+3027).

### Shape of return

### Notes

## kDaeJaweon
### Description
> The position of this character in the Dae Jaweon (Korean) dictionary used in the four-dictionary sorting algorithm. The position is in the form “page.position” with the final digit in the position being “0” for characters actually in the dictionary and “1” for characters not found in the dictionary and assigned a “virtual” position in the dictionary.

> Thus, “1187.060” indicates the sixth character on page 1187. A character not in this dictionary but assigned a position between the 6th and 7th characters on page 1187 for sorting purposes would have the code “1187.061”

> The edition used is the first edition, published in Seoul by Samseong Publishing Co., Ltd., 1988.

### Shape of return

### Notes

## kFennIndex
### Description
>  	The position of this character in The Five Thousand Dictionary by Courtenay H. Fenn, Cambridge, Mass.: Harvard University Press, 1979. The position is indicated by a three-digit page number followed by a period and a two-digit position on the page.

### Shape of return

### Notes

## kGSR
### Description
> The position of this character in Bernhard Karlgren’s Grammata Serica Recensa (1957).

> This dataset contains a total of 7,405 records. References are given in the form DDDDa('), where “DDDD” is a set number in the range [0001..1260] zero-padded to 4-digits, “a” is a letter in the range [a..z] (excluding “w”), optionally followed by apostrophe ('). The data from which this mapping table is extracted contains a total of 10,023 references. References to inscriptional forms have been omitted.

This entry is abridged.  See [Annex #38](https://www.unicode.org/reports/tr38/#kGSR) for a more complete description.

### Shape of return

### Notes

## kHanYu
### Description
> The position of this character in the Hànyǔ Dà Zìdiǎn (HDZ) Chinese character dictionary (bibliographic information below).

> The character references are given in the form “ABCDE.XYZ”, in which: “A” is the volume number [1..8]; “BCDE” is the zero-padded page number [0001..4809]; “XY” is the zero-padded number of the character on the page [01..32]; “Z” is “0” for a character actually in the dictionary, and greater than 0 for a character assigned a “virtual” position in the dictionary. For example, 53024.060 indicates an actual HDZ character, the 6th character on Page 3,024 of Volume 5 (i.e. 籉 [U+7C49]). Note that the Volume 8 “BCDE” references are in the range [0008..0044] inclusive, referring to the pagination of the “Appendix of Addendum” at the end of that volume (beginning after p. 5746).

> The first character assigned a given virtual position has an index ending in 1; the second assigned the same virtual position has an index ending in 2; and so on.

This entry is abridged.  See [Annex #38](https://www.unicode.org/reports/tr38/#kHanYu) for a more complete description.

### Shape of return

### Notes

## kIRGDaeJaweon
### Description
> The position of this character in the Dae Jaweon (Korean) dictionary used in the four-dictionary sorting algorithm. The position is in the form “page.position” with the final digit in the position being “0” for characters actually in the dictionary and “1” for characters not found in the dictionary and assigned a “virtual” position in the dictionary.

> Thus, “1187.060” indicates the sixth character on page 1187. A character not in this dictionary but assigned a position between the 6th and 7th characters on page 1187 for sorting purposes would have the code “1187.061”

> This field represents the official position of the character within the Dae Jaweon dictionary as used by the IRG in the four-dictionary sorting algorithm.

> The edition used is the first edition, published in Seoul by Samseong Publishing Co., Ltd., 1988.

### Shape of return

### Notes

## kIRGDaiKanwaZiten
### Description
>  	The index of this character in the Dai Kanwa Ziten, aka Morohashi dictionary (Japanese) used in the four-dictionary sorting algorithm. This field represents the official position of the character within the Dai Kanwa Ziten as used by the IRG in the four-dictionary sorting algorithm. The edition used is the revised edition, published in Tokyo by Taishuukan Shoten, 1986.

### Shape of return

### Notes

## kIRGHanyuDaZidian
### Description
> The position of this character in the Hànyǔ Dà Zìdiǎn (PRC) dictionary used in the four-dictionary sorting algorithm. The position is in the form “volume page.position” with the final digit in the position being “0” for characters actually in the dictionary and “1” for characters not found in the dictionary and assigned a “virtual” position in the dictionary.

> Thus, “32264.080” indicates the eighth character on page 2264 in volume 3. A character not in this dictionary but assigned a position between the 8th and 9th characters on this page for sorting purposes would have the code “32264.081”

> This field represents the official position of the character within the Hànyǔ Dà Zìdiǎn dictionary as used by the IRG in the four-dictionary sorting algorithm.

> The edition of the Hanyu Da Zidian used is the first edition, published in Chengdu by Sichuan Cishu Publishing, 1986.

### Shape of return

### Notes

## kIRGKangXi
### Description
> The official IRG position of this character in the 《康熙字典》 Kangxi Dictionary used in the four-dictionary sorting algorithm. The position is in the form “page.position” with the final digit in the position being “0” for characters actually in the dictionary and “1” for characters not found in the dictionary but assigned a “virtual” position in the dictionary.

> Thus, “1187.060” indicates the sixth character on page 1187. A character not in this dictionary but assigned a position between the 6th and 7th characters on page 1187 for sorting purposes would have the code “1187.061”.

> The edition of the Kangxi Dictionary used is the 7th edition published by Zhonghua Bookstore in Beijing, 1989.

> The values in the `kIRGKangXi` field are a strict subset of those in the `kKangXi` field.

### Shape of return

### Notes

## kKangXi
### Description
>  	The position of this character in the《康熙字典》Kangxi Dictionary used in the four-dictionary sorting algorithm. The position is in the form “page.position” with the final digit in the position being “0” for characters actually in the dictionary and “1” for characters not found in the dictionary but assigned a “virtual” position in the dictionary.

> Thus, “1187.060” indicates the sixth character on page 1187. A character not in this dictionary but assigned a position between the 6th and 7th characters on page 1187 for sorting purposes would have the code “1187.061”.

> The edition of the Kangxi Dictionary used is the 7th edition published by Zhonghua Bookstore in Beijing, 1989.

> The values in the `kKangXi` field are a strict superset of those in the `kIRGKangXi` field.

### Shape of return

### Notes

## kKarlgren
### Description
> The index of this character in Analytic Dictionary of Chinese and Sino-Japanese by Bernhard Karlgren, New York: Dover Publications, Inc., 1974.

> If the index is followed by an asterisk (*), then the index is an interpolated one, indicating where the character would be found if it were to have been included in the dictionary. Note that while the index itself is usually an integer, there are some cases where it is an integer followed by an “A”.

### Shape of return

### Notes

## kLau
### Description
> The index of this character in A Practical Cantonese-English Dictionary by Sidney Lau, Hong Kong: The Government Printer, 1977. The index consists of an integer. Missing indices indicate characters to be found in [UAX45]. 

### Shape of return

### Notes

## kMatthews
### Description
> The index of this character in Chinese-English Dictionary by Robert H. Mathews, Cambridge: Harvard University Press, 1975.

> Note that the field name is kMatthews instead of kMathews to maintain compatibility with earlier versions of this file, where it was inadvertently misspelled.
### Shape of return

### Notes

## kMeyerWempe
### Description
> The index of this character in the Student’s Cantonese-English Dictionary by Bernard F. Meyer and Theodore F. Wempe (3rd edition, 1947). The index is an integer, optionally followed by a lowercase Latin letter if the listing is in a subsidiary entry and not a main one. In some cases, where the character is found in the radical-stroke index, but not in the main body of the dictionary, the integer is followed by an asterisk: for example, U+50E5 僥, which is listed as 736* as well as 1185a.

### Shape of return

### Notes

## kMorohashi
### Description
> The index of this character in the Dai Kanwa Ziten, aka Morohashi dictionary (Japanese) used in the four-dictionary sorting algorithm. The edition used is the revised edition, published in Tokyo by Taishūkan Shoten, 1986.

### Shape of return

### Notes

## kNelson
### Description
> The index of this character in The Modern Reader’s Japanese-English Character Dictionary by Andrew Nathaniel Nelson, Rutland, Vermont: Charles E. Tuttle Company, 1974.

### Shape of return

### Notes

## kSBGY
### Description
> The position of this character in the Song Ben Guang Yun (SBGY) Medieval Chinese character dictionary (bibliographic and general information below).

> The 25334 character references are given in the form “ABC.XY”, in which: “ABC” is the zero-padded page number [004..546]; “XY” is the zero-padded number of the character on the page [01..73]. For example, 364.38 indicates the 38th character on Page 364 (i.e. 澍). Where a given Unicode Scalar Value (USV) has more than one reference, these are space-delimited.

This is an abridged entry.  For details see [Annex #38](https://www.unicode.org/reports/tr38/#kSBGY).

### Shape of return

### Notes
