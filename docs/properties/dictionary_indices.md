# Dictionary Indices

## kCheungBauerIndex
### Description
> The position of the ideograph in Cheung Kwan-hin and Robert S. Bauer, The Representation of Cantonese with Chinese Characters, Journal of Chinese Linguistics, Monograph Series Number 18, 2002. The format is a three-digit page number followed by a two-digit position number, separated by a period.

### Shape of return

```elixir
%{
    page: 381,
    position: 1
}
```

Both `:page` and `:position` are integers.

Where multiple entries were provided in Cheung & Bauer, the entries are provided as a list:

```elixir
   [
     %{page: 366, position: 5},
     %{page: 366, position: 6},
     %{page: 366, position: 7},
     %{page: 366, position: 8}
   ]
```

### Notes

Cheung Bauer includes 967 characters specifically used in representing Cantonese.  Examples include 㖭,㗎, and 𬧊.  Note that many of these characters reside in the Extension planes and may not be contained in standard fonts.

## kCihaiT
### Description
> The position of this ideograph in the Cihai (辭海) dictionary, single volume edition, published in Hong Kong by the Zhonghua Bookstore, 1983 (reprint of the 1947 edition), ISBN 962-231-005-2.

> The position is indicated by a decimal number. The digits to the left of the decimal are the page number. The first digit after the decimal is the row on the page, and the remaining two digits after the decimal are the position on the row.

### Shape of return

```elixir
%{page: 1552, position: 7, row: 4}
```

All three values are integers.

### Notes

13,886 characters contains an `:kCihaiT` field.  These are exclusively Traditional characters.

## kCowles
### Description
> The index or indices of this ideograph in Roy T. Cowles, A Pocket Dictionary of Cantonese, Hong Kong: University Press, 1999.

> The Cowles indices are numerical, usually integers but occasionally fractional where an ideograph was added after the original indices were determined. Cowles is missing indices 1222 and 4949, and four ideographs in Cowles are part of Unicode’s “Hangzhou” numeral set: 2964 (U+3025), 3197 (U+3028), 3574 (U+3023), and 4720 (U+3027).

### Shape of return

`:kCowles` returns *exclusively* an integer.

### Notes

4863 Traditional characters.  Note that trailing decimals are dropped in this parsing implementation.

## kDaeJaweon
### Description
> The position of this ideograph in the Dae Jaweon (Korean) dictionary used in the four-dictionary sorting algorithm. The full name of this dictionary in Korean is 漢韓大辭典 大字源 (한한대사전 대자원). The position is in the form “page.position” with the final digit in the position being “0” for ideographs actually in the dictionary and “1” for ideographs not found in the dictionary and assigned a “virtual” position in the dictionary.

> Thus, “1187.060” indicates the sixth ideograph on page 1187. An ideograph not in this dictionary but assigned a position between the 6th and 7th ideographs on page 1187 for sorting purposes would have the code “1187.061”

> The edition used is the first edition, published in Seoul by Samseong Publishing Co., Ltd. (三省出版社 삼성출판사), 1988.

### Shape of return

### Notes

## kFennIndex
### Description
> The position of this ideograph in The Five Thousand Dictionary by Courtenay H. Fenn, Cambridge, Mass.: Harvard University Press, 1979. The position is indicated by a three-digit page number followed by a period and a two-digit position on the page.

### Shape of return

### Notes

## kGSR
### Description
> The position of this ideograph in Bernhard Karlgren’s Grammata Serica Recensa (1957).

> This dataset contains a total of 7,405 records. References are given in the form DDDDa('), where “DDDD” is a set number in the range [0001..1260] zero-padded to four digits, “a” is a letter in the range [a..z] (excluding “w”), optionally followed by apostrophe (U+0027'APOSTROPHE). The data from which this mapping table is extracted contains a total of 10,023 references. References to inscriptional forms have been omitted.

> • Release notes:

> Changes since the initial release:

> Added: [U+25053] : 0995m (2009-01-01);

> Added: [U+65d6] : 0001l' (2008-11-17).

> 22-Dec-2003: Initial release. The following 32 references are to unencoded forms: 0059k, 0069y, 0079d, 0275b, 0286a, 0289a, 0289f, 0293a, 0325a, 0389o, 0391h, 0392s, 0468h, 0480a, 0516a, 0526o, 0566g', 0642y, 0661a, 0739i, 0775b, 0837h, 0893r, 0969a, 0969e, 1019e, 1062b, 1112d, 1124l, 1129c', 1144a, 1144b. In some cases, a variant mapping has been substituted in the mapping table, in other cases the reference is omitted.

> • Bibliographic information:

> Karlgren, Klas Bernhard Johannes 高本漢 (1889–1978): 2000. Grammata Serica Recensa Electronica. Electronic version of GSR, including indices, syllable canon, and images of the original Karlgren (1957) text. Prepared for the STEDT Project by Richard Cook; based in part on work by Tor Ulving and Ferenc Tafferner (see below), used by permission. Berkeley: University of California.

> Karlgren 1957. Grammata Serica Recensa. First published in the Bulletin of the Museum of Far Eastern Antiquities (BMFEA) No. 29, Stockholm, Sweden. Reprinted by Elanders Boktrycker Aktiebolag, Kungsbacka, [1972]. Reprinted also by SMC Publishing Inc., Taipei, Taiwan, ROC, [1996]. ISBN: 957-638-269-6.

> Karlgren 1940. Grammata Serica: Script and Phonetics in Chinese and Sino-Japanese 《中日漢字形聲論》Zhong-Ri Hanzi Xingsheng Lun [A study of Sino-Japanese semantic-phonetic compound characters:] BMFEA No. 12. Reprinted, Taipei: Ch’eng-Wen Publishing Company, [1966].

> Ulving, Tor: 1997. Dictionary of Old and Middle Chinese: Bernhard Karlgren’s Grammata Serica Recensa Alphabetically Arranged. With Ferenc Tafferner. Göteborg, Sweden: Acta Universitatis Gothoburgensis. Orientalia Gothoburgensia, 11. ISBN: 91-7346-294-2.

### Shape of return

### Notes

## kHanYu
### Description
> The position of this ideograph in the Hànyǔ Dà Zìdiǎn (HDZ) Chinese character dictionary (bibliographic information below).

> The ideograph references are given in the form “ABCDE.XYZ”, in which: “A” is the volume number [1..8]; “BCDE” is the zero-padded page number [0001..4809]; “XY” is the zero-padded number of the ideograph on the page [01..32]; “Z” is “0” for an ideograph actually in the dictionary, and greater than 0 for an ideograph assigned a “virtual” position in the dictionary. For example, 53024.060 indicates an actual HDZ ideograph, the 6th ideograph on Page 3,024 of Volume 5 (i.e. 籉 [U+7C49]). Note that the Volume 8 “BCDE” references are in the range [0008..0044] inclusive, referring to the pagination of the “Appendix of Addendum” at the end of that volume (beginning after p. 5746).

> The first ideograph assigned a given virtual position has an index ending in 1; the second assigned the same virtual position has an index ending in 2; and so on.

> -- Release information --

> This data set contains a total of 56098 HDZ references, 54729 of which are actual HDZ ideograph references (positions are given for all HDZ head entries, including source-internal unifications), and 1369 of which are virtual ideograph positions (see note below).

> A total of 55,818 distinct Han ideographs are assigned mappings in this data. Because of IRG source-internal unifications, a given ideograph may have more than one HDZ reference. Source-internal unifications are of two types: (1) unifications of graphical variants; (2) unifications of duplicate head entries.

> The proofing of all references was done primarily on the basis of cross-checks of three versions of the reference data: (1) the original print source; (2) the kIRGHanyuDaZidian property of the Unihan database (release 3.1.1d1); (3) “HDZ.txt”, originally produced and proofed for Academia Sinica’s Institute of Information Technology (Document Processing Laboratory). In addition, the data was checked against the kHanYu and kAlternateHanYu properties of the Unihan database (release 3.1.1d1), which the present data set supersedes.

> String value, string length, compound key, field count, and page total validations were all performed. Altogether, 578 omissions/ errors in source (2) were identified/corrected. Any remaining errors will likely relate to virtual positions, or to the ordering of actual ideographs within a given page. It is unlikely that errors across page breaks remain. Possible future disunifications of source-internal unifications will necessitate update of the Unicode Scalar Value for some references. Under no circumstances should the source-internal unification (duplicate Unicode Scalar Value) mappings be removed from this data set.

> Note: Source (3) contributed only actual HDZ ideograph references to the proofing process, while source (2) contributed all virtual positions. It seems that the compilers of source (2) usually assigned virtual positions based on stroke count, though occasionally the virtual position brings the virtual ideograph together with the actual HDZ ideograph of which it is a variant, without regard to actual stroke count.

> -- Bibliographic information for the print source --

> <Hanyu Da Zidian> [‘Great Chinese Character Dictionary’ (in 8 Volumes)]. XU Zhongshu (Editor in Chief). Wuhan, Hubei Province (PRC): Hubei and Sichuan Dictionary Publishing Collectives, 1986-1990. ISBN: 7-5403-0030-2/H.16.

> 《漢語大字典》。許力以主任，徐中舒主編，（漢語大字典工作委員會）。武漢：四川辭書出版社，湖北辭書出版社,1986-1990. ISBN: 7-5403-0030-2/H.16.

> Note that the property name is kHanYu instead of kHanyu to maintain compatibility with earlier versions of this file, where it was inappropriately spelled with an uppercase Y.

### Shape of return

### Notes

## kIRGHanyuDaZidian
### Description
> The position of this ideograph in the Hànyǔ Dà Zìdiǎn (PRC) dictionary used in the four-dictionary sorting algorithm. The position is in the form “volume page.position” with the final digit in the position being “0” for ideographs actually in the dictionary and “1” for ideographs not found in the dictionary and assigned a “virtual” position in the dictionary.

> Thus, “32264.080” indicates the eighth ideograph on page 2264 in volume 3. An ideograph not in this dictionary but assigned a position between the 8th and 9th ideographs on this page for sorting purposes would have the code “32264.081”

> This property represents the official position of the ideograph within the Hànyǔ Dà Zìdiǎn dictionary as used by the IRG in the four-dictionary sorting algorithm.

> The edition of the Hanyu Da Zidian used is the first edition, published in Chengdu by Sichuan Cishu Publishing, 1986.

### Shape of return

### Notes

## kKangXi
### Description
> The position of this ideograph in the《康熙字典》Kangxi Dictionary used in the four-dictionary sorting algorithm. The position is in the form “page.position” with the final digit in the position being “0” for ideographs actually in the dictionary and “1” for ideographs not found in the dictionary but assigned a “virtual” position in the dictionary.

> Thus, “1187.060” indicates the sixth ideograph on page 1187. An ideograph not in this dictionary but assigned a position between the 6th and 7th ideographs on page 1187 for sorting purposes would have the code “1187.061”.

> The edition of the Kangxi Dictionary used is the 7th edition published by Zhonghua Bookstore in Beijing, 1989.

### Shape of return

### Notes

## kKarlgren
### Description
> The index of this ideograph in Analytic Dictionary of Chinese and Sino-Japanese by Bernhard Karlgren, New York: Dover Publications, Inc., 1974.

> If the index is followed by an asterisk (*), then the index is an interpolated one, indicating where the ideograph would be found if it were to have been included in the dictionary. Note that while the index itself is usually an integer, there are some cases where it is an integer followed by an “A.”

### Shape of return

### Notes

## kLau
### Description
> The index of this ideograph in A Practical Cantonese-English Dictionary by Sidney Lau, Hong Kong: The Government Printer, 1977.

> The index consists of an integer. Missing indices indicate ideographs to be found in Unicode Standard Annex #45, “U-Source Ideographs” [UAX45].

### Shape of return

### Notes

## kMatthews
### Description
> The index of this ideograph in Chinese-English Dictionary by Robert H. Mathews, Cambridge: Harvard University Press, 1975.

> Note that the property name is kMatthews instead of kMathews to maintain compatibility with earlier versions of this file, where it was inadvertently misspelled.

### Shape of return

### Notes

## kMeyerWempe
### Description
> The index of this ideograph in The Student’s Cantonese-English Dictionary by Bernard F. Meyer and Theodore F. Wempe (3rd edition, 1947). The index is an integer, optionally followed by a lowercase Latin letter if the listing is in a subsidiary entry and not a main one. In some cases, where the ideograph is found in the radical-stroke index, but not in the main body of the dictionary, the integer is followed by an asterisk: for example, U+50E5 僥, which is listed as 736* as well as 1185a.

### Shape of return

### Notes

## kMorohashi
### Description
> The index of the ideograph in the Dai Kanwa Jiten (大漢和辞典) Japanese kanji dictionary (1984–1986, 大修館書店)—often referred to as Morohashi (諸橋), the family name of its chief editor—or in the Dai Kanwa Jiten Hokan (大漢和辞典 補巻) supplemental volume (2000, 大修館書店).

> Index numbers are five zero-padded integer values with an optional single apostrophe (U+0027'APOSTROPHE) or double apostrophe ('') suffix that corresponds in appearance to a prime or double prime. Index numbers that appear in the supplemental volume (補巻) are prefixed with “H” and consist of three zero-padded integer values.

> If a colon (:) and VS (Variation Selector) follow an index number, the sequence of the CJK Unified Ideograph, serving as a BC (Base Character), followed by the VS, corresponds to the index number. Such sequences are SVSes or Moji_Joho IVSes.

> If an index number appears both by itself and followed by a colon and VS, the registered Moji_Joho IVS that corresponds to the latter is considered the default (that is, encoded) form of the CJK Unified Ideograph.

> The Moji Jōhō Kiban database and its mappings are owned by CITPC (Character Information Technology Promotion Council 文字情報技術促進協議会), and are used under license.

### Shape of return

```elixir
%{index: 45958, prime: "", supplement: false}
```

* `:index` is the integer index and `:supplement` is `true` for the "H"-prefixed indices into the supplemental volume.

* `:prime` is `""`, `"'"` or `"''"`.

* `:variation_selector` is present, as an integer code point, when the index applies to a variation sequence rather than the base ideograph.

### Notes

## kNelson
### Description
> The index of this ideograph in The Modern Reader’s Japanese-English Character Dictionary by Andrew Nathaniel Nelson, Rutland, Vermont: Charles E. Tuttle Company, 1974.

### Shape of return

### Notes

## kSBGY
### Description
> The position of this ideograph in the Song Ben Guang Yun (SBGY) Medieval Chinese character dictionary (bibliographic and general information below).

> The 25,334 ideograph references are given in the form “ABC.XY”, in which: “ABC” is the zero-padded page number [004..546]; “XY” is the zero-padded number of the ideograph on the page [01..73]. For example, 364.38 indicates the 38th ideograph on Page 364 (i.e. 澍). Where a given Unicode Scalar Value has more than one reference, these are space-delimited.

> -- Release information (20080814) --

> This release corrects several mappings. This data set now contains a total of 25,334 references, for 19,583 different hanzi.

> -- Release information (2003-10-05) --

> This release corrects several mappings.

> -- Release information (2002-03-10) --

> This data set contains a total of 25,334 references, for 19,572 different hanzi (up from 25,330 and 19,511 in the previous release).

> This release of the kSBGY data fixes a number of mappings, based on extensive work done since the initial release (compare the initial release counts given below). See the end of this header for additional information.

> -- Initial release information (2002-03-10) --

> The original data was input under the direction of Professor LUO Fengzhu at Taiwan Taoyuanxian Yuan Zhi University (see below) using an early version of the Big5-based CDP encoding scheme developed at Academia Sinica. During 2000–2002 this raw data was processed and revised by Richard Cook as follows: the data was converted to Unicode encoding using his revised kHanYu mapping tables (first provided to the Unicode Consortium for the Unihan database release 3.1.1d1) and also using several other mapping tables developed specifically for this project; the kSBGY indices were generated based on hand-counts of all page totals; numerous indexing errors were corrected; and the data underwent final proofing.

> -- About the print sources --

> The SBGY text, which dates to the beginning of the Song Dynasty (c. 1008, edited by 陳彭年 CHEN Pengnian et al.) is an enlargement of an earlier text known as 《切韻》 Qie Yun (dated to c. 601, edited by 陸法言 LU Fayan). With 25,330 head entries, this large early lexicon is important in part for the information which it provides for historical Chinese phonology. The GY dictionary employs a Chinese transcription method (known as 反切) to give pronunciations for each of its head entries. In addition, each syllable is also given a brief gloss.

> It must be emphasized that the mapping of a particular SBGY glyph to a single Unicode Scalar Value may in some cases be merely an approximation or may have required the choice of a “best possible glyph” (out of those available in the Unicode repertoire). This indexing data in conjunction with the print sources will be useful for evaluating the degree of distinctive variation in the ideograph forms appearing in this text, and future proofing of this data may reveal additional Chinese glyphs for IRG encoding.

> -- Bibliographic information on the print sources --

> 《宋本廣韻》 <<Song Ben Guang Yun>> [‘Song Dynasty edition of the Guang Yun Rhyming Dictionary’], edited by 陳彭年 CHEN Pengnian et al. (c. 1008).

> Two modern editions of this work were consulted in building the kSBGY indices:

> 《新校正切宋本廣韻》。台灣黎明文化事業公司 出版，林尹校訂1976 年出版。[This was the edition used by Prof. LUO (台灣桃園縣元智大學中語系羅鳳珠), and in the subsequent revision, conversion, indexing and proofing.]

> 《新校互註‧宋本廣韻》。香港中文大學,余迺永 1993, 2000 年出版。ISBN: 962-201-413-5; 7-5326-0685-6. [Textual problems were resolved on the basis of this extensively annotated modern edition of the text.]

> -- Additional Information --

> For further information on this index data and the databases from which it is excerpted, see:

> Cook, Richard S. 2003. 《說文解字‧電子版》 Shuo Wen Jie Zi - Dianzi Ban: Digital Recension of the Eastern Han Chinese Grammaticon. PhD Dissertation. Department of Linguistics. Berkeley: University of California.

### Shape of return

### Notes

## kSMSZD2003Index
### Description
> This represents the position(s) of the ideograph in the Soengmou San Zidin (商務新字典, New Commercial Press Character Dictionary). The format is the page within the dictionary followed by the position on the page.

> If multiple values are present, the first is the primary entry for the ideograph. Other entries are simply cross-references to the primary entry and are in numeric order.

> The complete bibliographic information for the Soengmou San Zidin is:

> Wong Gongsang 黃港生, ed. Shangwu Xin Zidian / Soengmou San Zidin 商務新字典 (New Commercial Press Character Dictionary). Hong Kong: 商務印書館(香港)有限公司 (Commercial Press [Hong Kong], Ltd.), 2003. ISBN 962-07-0140-2.

### Shape of return

```elixir
%{page: 41, position: 3}
```

Where multiple positions are given the entries are returned as a list, the first being the primary entry.

### Notes
