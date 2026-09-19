# Readings

## kCantonese
### Description
> The most customary jyutping (Cantonese) reading for this ideograph.

> This property is targeted specifically for use by CLDR collation and transliteration. As such, it is subject to considerations that help keep jyutping-based Han collation (and its tailorings) and transliteration reasonably stable. The values may not in all cases track the preferred reading in some dictionaries.

> Among the sources used for Cantonese data are the following:

> Casey, G. Hugh, S.J. Ten Thousand Characters: An Analytic Dictionary. Hong Kong: Kelley and Walsh, 1980. (kPhonetic)

> Cheung Kwan-hin, and Robert S. Bauer, The Representation of Cantonese with Chinese Characters, Journal of Chinese Linguistics Monograph Series Number 18, 2002. ISSN 0091-3723 (kCheungBauer, kCheungBauerIndex)

> Cowles, Roy T. A Pocket Dictionary of Cantonese. Hong Kong: University Press, 1999. ISBN 962-209-122-9 (kCowles)

> Jiu Bingcoi 饒秉才, ed. Guangzhou Yin Zidian / Gwongzau Jam Zidin 廣州音字典 (Guangzhou Pronouncing Character Dictionary). Hong Kong: Joint Publishing (H.K.) Co., Ltd, 1989. ISBN 962-04-0389-4

> Langwen Chuji Zhongwen Cidian / Longman Cokap Zungman Cidin 朗文初級中文詞典 (Longman’s Elementary Chinese Dictionary). Hong Kong: Longman, 2001. ISBN 962-00-5148-3

> Lau, Sidney. A Practical Cantonese-English Dictionary. Hong Kong: Government Printer, 1977 (kLau).

> Meyer, Bernard F., and Theodore F. Wempe. The Student’s Cantonese-English Dictionary. Maryknoll, New York: Catholic Foreign Mission Society of America, 1947 (kMeyerWempe).

> Wong Gongsang 黃港生, ed. Shangwu Xin Cidian / Soengmou San Cidin 商務新詞典 (New Commercial Press Dictionary). Hong Kong: 商務印書館(香港)有限公司 (Commercial Press [Hong Kong], Ltd.), 1991. ISBN 962-07-0133-X

> Wong Gongsang 黃港生, ed. Shangwu Xin Zidian / Soengmou San Zidin 商務新字典 (New Commercial Press Character Dictionary). Hong Kong: 商務印書館(香港)有限公司 (Commercial Press [Hong Kong], Ltd.), 2003. ISBN 962-07-0140-2 (kSMSZD2003Index and kSMSZD2003Readings)

> Zhonghua Xin Zidian / Zungwaa San Zidin 中華新字典 (New Chung Hwa Character Dictionary). Hong Kong: 中華書局 (Chung Hwa Book Co.), 2003. ISBN 962-231-001-X

### Shape of return

### Notes

## kDefinition
### Description
> An English definition for this ideograph. Definitions are for modern written Chinese and are usually (but not always) the same as the definition in other Chinese dialects or non-Chinese languages. In some cases, synonyms are indicated. Fuller variant information can be found using the various variant properties.

> Definitions specific to non-Chinese languages or Chinese dialects other than modern Mandarin are marked, for example, (Cant.) or (J).

> Major definitions are separated by semicolons, and minor definitions by commas. However, semicolons and commas may also occur anywhere within major definitions and minor definitions, meaning that the text cannot be parsed into separate definitions using those punctuation characters. Any valid Unicode character (except for tab, double-quote, and any line break character) may be used within the kDefinition property.

### Shape of return

### Notes

## kFanqie
### Description
> Fanqie (反切) is a method commonly found in ancient Chinese dictionaries and rhyming books to specify the reading of an ideograph. The method uses two ideographs to specify a reading: the first one shares the same initial part, and the second one shares the same final part. For example, 德 (tək) and 紅 (ɣuŋ) are used to indicate the Middle Chinese reading of 東 (tuŋ), and therefore the kFanqie property value of U+6771 東 is the ideograph pair 德紅. The method uses a third and final ideograph, which can be either 反 or 切 (the two ideographs that correspond to Fanqie), and is therefore not included as part of the kFanqie property value.

> Much of the property data is based on the dictionary that serves as the basis of the kSBGY property, but the scope of this property is not limited to that particular dictionary.

### Shape of return

A string of the two ideographs, or a list of them where there are multiple readings:

```elixir
"德紅"
```

### Notes

## kHangul
### Description
> The modern Korean pronunciation(s) for this ideograph in Hangul, with its source(s) following a colon.

> A value of 0 corresponds to KS X 1001, a value of 1 corresponds to KS X 1002, a value of E corresponds to 한문 교육용 기초 한자 (漢文敎育用基礎漢字), and a value of N corresponds to 인명용 한자 (人名用漢字).  A value of X indicates that a K-source was formerly at that code point but was later removed.

### Shape of return

### Notes

## kHanyuPinlu
### Description
> The Pronunciations and Frequencies of this ideograph, based in part on those appearing in 《現代漢語頻率詞典》 <Xiandai Hanyu Pinlu Cidian> (XDHYPLCD) [Modern Standard Beijing Chinese Frequency Dictionary] (complete bibliographic information below).

> Data Format

> This dataset contains a total of 3799 records. (The original data provided to Unihan on 2003-02-04 contained a total of 3800 records, including U+3007 〇 IDEOGRAPHIC NUMBER ZERO, not included in the Unihan database since it is not a CJK Unified Ideograph.)

> Each entry is comprised of two pieces of data.

> The Hanyu Pinyin (HYPY) pronunciation(s) of the ideograph.

> Immediately following the pronunciation, a numeric string appears in parentheses: for example, in “ā(392)” the numeric string “392” indicates the sum total of the frequencies of the pronunciations of the ideograph as given in HYPLCD.

> Where more than one pronunciation exists, these are sorted by descending frequency, and the list elements are “space” delimited.

> Release Information

> The XDHYPLCD data here for Modern Standard Chinese (Putonghua) cuts across 4 genres (“News,” “Scientific,” “Colloquial,” and “Literature”), and was derived from a 1,807,389 ideograph corpus. See that text for additional information.

> The 8548 entries (8586 with variant writings) from p. 491–656 of XDHYPLCD were input by hand and proof-read from 1994-08-04 to 1995-03-22 by Richard Cook.

> Current Release Date above reflects date of last proofing.

> HYPY transcription for the data in this release was semiautomated and hand-corrected in 1995, based in part on data provided by Ross Paterson (Department of Computing, Imperial College, London).

> Tom Bishop is also due thanks for early assistance in proof-reading this data.

> The character set used for this digitization of HYPLCD (a “simplified” mainland PRC text) was (Mac OS 7-9) GB/T 2312-1980 (plus 嗐).

> These data were converted to Big5 (plus 腈), and both GB and Big5 versions were separately converted to Unicode 4.0, and then merged, resulting in the 3800 records in the original release. Frequency data for simplified polysyllabic words has been employed to generate both simplified and traditional ideograph frequencies.

> Bibliographic information for the primary print source

> 《現代漢語頻率詞典》，北京語言學院語言教學研究所編著。

> <Xiandai Hanyu Pinlu Cidian> = XDHYPLCD First edition 1986/6, 2nd printing 1990/4. ISBN 7-5619-0094-5/H.67.

### Shape of return

### Notes

## kHanyuPinyin
### Description
> The 漢語拼音 Hànyǔ Pīnyīn reading(s) appearing in the edition of 《漢語大字典》 Hànyǔ Dà Zìdiǎn (HDZ) specified in the kHanYu property description (q.v.). Each location has the form “ABCDE.XYZ” (as in kHanYu); multiple locations for a given pīnyīn reading are separated by commas. The list of locations is followed by a colon, followed by a comma-separated list of one or more pīnyīn readings. Where multiple pīnyīn readings are associated with a given mapping, these are ordered as in HDZ (for the most part reflecting relative commonality). The following are representative records.

> | U+34CE | 㓎 | 10297.260: qīn,qìn,qǐn |         | U+34D8 | 㓘 | 10278.080,10278.090: sù |         | U+5364 | 卤 | 10093.130: xī,lǔ 74609.020: lǔ,xī |         | U+5EFE | 廾 | 10513.110,10514.010,10514.020: gǒng |

> For example, the kHanyuPinyin value for U+5364 卤 is “10093.130: xī,lǔ 74609.020: lǔ,xī.” This means that U+5364 卤 is found in kHanYu at entries 10093.130 and 74609.020. The former entry has the two pīnyīn readings xī and lǔ (in that order), whereas the latter entry has the readings lǔ and xī (reversing the order).

> This data was originally input by 井作恆 Jǐng Zuòhéng, proofed by 聃媽歌 Dān Māgē (Magda Danish, using software donated by 文林 Wénlín Institute, Inc. and tables prepared by 曲理查 Qū Lǐchá), and proofed again and prepared for the Unicode Consortium by 曲理查 Qū Lǐchá (2008-01-14).

> -- Release Notes --

> This data set includes readings for 34,130 distinct HDZ Hànzì, 34,302 HDZ references, and 1,457 distinct pīnyīn syllables.

### Shape of return

### Notes

## kJapanese
### Description
> The Japanese readings(s) for this ideograph expressed in Kana. Readings expressed in Hiragana are generally considered Kun-yomi (訓読み), and readings expressed in Katakana are generally considered On-yomi (音読み).

> The Moji Jōhō Kiban database and its Japanese readings are owned by   CITPC (Character Information Technology Promotion Council   文字情報技術促進協議会), and are used under license.

### Shape of return

A kana string, or a list of them where there are multiple readings:

```elixir
["ギョ", "うお"]
```

### Notes

## kJapaneseKun
### Description
> The Japanese pronunciation(s) of this ideograph in the Hepburn romanization.

### Shape of return

### Notes

## kJapaneseOn
### Description
> The Sino-Japanese pronunciation(s) of this ideograph.

### Shape of return

### Notes

## kKorean
### Description
> The Korean pronunciation(s) of this ideograph, using the Yale romanization system. See Romanization of Korean (Wikipedia) for a discussion of the various Korean romanization systems.

> Use of the kKorean property is not recommended. The kHangul property, which is aligned to the KS X 1001 and KS X 1002 standards, 한문 교육용 기초 한자 (漢文敎育用基礎漢字), and 인명용 한자 (人名用漢字), is recommended to be used instead.

### Shape of return

### Notes

## kMandarin
### Description
> The most customary pīnyīn reading for this ideograph. When there are two values, then the first is preferred for zh-Hans (CN) and the second is preferred for zh-Hant (TW). When there is only one value, it is appropriate for both.

> This property is targeted specifically for use by CLDR collation and transliteration. As such, it is subject to considerations that help keep pīnyīn-based Han collation (and its tailorings) and transliteration reasonably stable. The values may not in all cases track the preferred use in some dictionaries.

### Shape of return

### Notes

## kSMSZD2003Readings
### Description
> This represents the Mandarin and Cantonese readings(s) of the ideograph in the Soengmou San Zidin (商務新字典, New Commercial Press Character Dictionary). The full bibliographic information for this dictionary is found in the description of the kSMSZD2003Index property.

> Mandarin readings are in hànyǔ pīnyīn. Cantonese readings are in jyutping. Note that some ideographs have readings which would ordinarily be considered invalid, such as polysyllabic readings.

> If an ideograph has multiple entries, it means that the ideograph has multiple definitions and the readings are grouped in order of those definitions.

### Shape of return

```elixir
%{
  mandarin: ["wàn"],
  cantonese: [
    %{jyutping: "maan6", onset: "m", nucleus: "aa", coda: "n", final: "aan", tone: "6"}
  ]
}
```

Cantonese readings are decoded as for `kCantonese`. Readings the dictionary treats as polysyllabic are not valid jyutping and are kept as strings.

### Notes

## kTang
### Description
> The Tang dynasty pronunciation(s) of this ideograph, derived from or consistent with T’ang Poetic Vocabulary by Hugh M. Stimson, Far Eastern Publications, Yale University 1976. These were reconstructed from the Qieyun 切韻, compiled in 601 AD, refined based on work by Bernhard Karlgren (for example, Grammata Serica Recensa). An asterisk indicates that the word or morpheme represented in toto or in part by the given ideograph with the given reading occurs more than four times in the seven hundred poems covered.

### Shape of return

### Notes

## kTGHZ2013
### Description
> One or more Hànyǔ Pīnyīn readings as given in Tōngyòng Guīfàn Hànzì Zìdiǎn (full bibliographic information below).

> Each pīnyīn reading is preceded by the ideograph’s location(s) in the dictionary, separated from the reading by a colon. Multiple locations for a given reading are separated by commas. Multiple “location: reading” values are separated by a space. Each location reference is of the form /d{3}\.\d{3}/. The number preceding the period is the page number, zero-padded to three digits. The first two digits of the number following the period are the entry’s position on the page, zero-padded. The third digit is 0 for a main entry and greater than 0 for a parenthesized or bracketed variant of the main entry.

> – Bibliographical information –

> 《通用规范汉字字典》(Tōngyòng Guīfàn Hànzì Zìdiǎn = TGHZ; ‘General Purpose Normalized Hanzi Dictionary’). 商务印书馆辞书研究中心编 (Dictionary Research Center of the Commercial Press, eds.). 北京: 商务印书馆, 2013 [2013年7月第1版; 2013年9月北京第3次印刷; 印张 22⅞; ISBN 978-7-100-05961-9].

> – Release Notes –

> This data was input and prepared by Jaemin Chung (initial release 2019-04-24).

> Distinct Unihan hànzì: 8,105

> Distinct pīnyīn syllables: 1,296

### Shape of return

### Notes

## kVietnamese
### Description
> The ideograph’s pronunciation(s) in Quốc ngữ.

### Shape of return

### Notes

## kXHC1983
### Description
> One or more Hànyǔ Pīnyīn readings as given in the Xiàndài Hànyǔ Cídiǎn (full bibliographic information below).

> Each pīnyīn reading is preceded by the ideograph’s location(s) in the dictionary, separated from the reading by a colon; multiple locations for a given reading are separated by commas; multiple “location: reading” values are separated by a space. Each location reference is of the form /\d{4}\.\d{3}\*?/. The number preceding the period is the page number, zero-padded to four digits. The first two digits of the number following the period are the entry’s position on the page, zero-padded. The third digit is 0 for a main entry and greater than 0 for a parenthesized variant of the main entry. A trailing asterisk (*) on the location indicates a unifiable variant substituted for an unencoded ideograph.

> -- Bibliographical information --

> 《现代汉语词典》 [Xiàndài Hànyǔ Cídiǎn = XHC; ‘Modern Chinese Dictionary’]. 中国社会科学院语言研究所词典编辑室编 [Chinese Academy of Social Sciences, Linguisitics Research Institute, Dictionary Editorial Office, eds.]. 北京: 商务印书馆, 1983 [1978 年 12 月第 1 版; 1983 年 1 月第 2 版; 1984 年 1 月北京第 49 次印刷印张 54; 统一书号: 17017.91].

> Note that although there are later editions of this important PRC dictionary, reflecting developments and refinements in language and orthographic standardization, these editions should not be used in future revisions to this property.

> -- Release Notes --

> The Unihan version of this data was originally prepared by Richard Cook (initial release 2007-12-12), proofing and revising a subset of data contributed by Dr. George Bell (who input it with the help of Joy Zhao Rouzer, Steve Mann, et al., as one part of their “Quick and Easy Index of Chinese Characters with Attributes”; Bell 1995-2005).

> Additional data and corrections were provided by Andrew West in 2022 for Unicode Version 15.1.

> Distinct Unihan hànzì: 10,992;

> Distinct hànzì: 11,190;

> Distinct pīnyīn syllable types: 1,337;

> As of Unicode Version 15.1, all ideographs in the dictionary which are not unifiable variants have been encoded. All are encoded as CJK Unified Ideographs, with one exception. The print source includes the entry “0719.100: líng” for U+3007 〇 IDEOGRAPHIC NUMBER ZERO. As this is not a CJK Unified Ideograph, it is not included in the Unihan database; see U+96F6 零.

### Shape of return

### Notes

## kZhuang
### Description
> The most customary Zhuang reading for this ideograph. Readings of words not part of the Standard Zhuang lexicon are suffixed by an asterisk.

> Among the sources used for the property data are the following:

> Ancient Zhuang Character Dictionary (古壮字字典), 1989, ISBN 7-5363-0614-8

### Shape of return

```elixir
%{reading: "ceiz", standard: true}
```

`:standard` is `false` for readings marked with an asterisk, which are not part of the Standard Zhuang lexicon.

### Notes
