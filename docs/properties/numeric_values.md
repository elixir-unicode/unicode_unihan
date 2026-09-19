# Numeric values

## kAccountingNumeric
### Description
> The value of the ideograph when used as an accounting numeral to prevent fraud in Chinese and derivative numeric systems. A numeral such as 十 (ten) is easily transformed into 千 (thousand) by adding a single stroke, so monetary documents often use an accounting form of the numeral, such as 拾 (ten), instead of the more common—and simpler—form. Ideographs with this property will have a single, well-defined value, which a native reader can reasonably be expected to understand.

> The three Chinese numeric-value properties should have no overlap; that is, ideographs with a kAccountingNumeric value should not have a kOtherNumeric or kPrimaryNumeric value as well.

### Shape of return

### Notes

## kOtherNumeric
### Description
> The value of the ideograph when used as a numeral in Chinese and derivative numeric systems. Ideographs with this property are rarely used, obsolete, domain-specific, non-standard, or non-compositional as a numeral. For example, 㠪 is a rare ideograph whose meaning, “five,” would not be recognized by most native readers; and 幺 “tiny,” normally not a numeral, can be used as the phonetic code for “one” in some regions. An English-language equivalent is “gross,” whose numeric value, “one hundred forty-four,” is not universally understood by native readers.

> The three Chinese numeric-value properties should have no overlap; that is, ideographs with a kOtherNumeric value should not have a kAccountingNumeric or kPrimaryNumeric value as well.

### Shape of return

### Notes

## kPrimaryNumeric
### Description
> One or more values of the ideograph when used as a numeral in Chinese and derivative numeric systems. Ideographs which have this property have numeric values that are common, or are standardized to convey a fixed numeric value. For example, 千 always means “thousand”. A native reader is expected to understand the numeric value for these ideographs. If an ideograph has more than one numeric value, the first one is to be considered the most common one, and that first value is used for the Numeric_Value property of the ideograph.

> The three Chinese numeric-value properties should have no overlap; that is, ideographs with a kPrimaryNumeric value should not have a kAccountingNumeric or kOtherNumeric value as well.

### Shape of return

### Notes

## kTayNumeric
### Description
> The value of the ideograph when used as a numeral in Tày languages with the Han script (Chữ Nôm Tày). It can be used alongside kPrimaryNumeric or kAccountingNumeric since the Chinese vocabulary of numbers is also imported in Tày; it can also be used alongside kVietnameseNumeric since the Vietnamese vocabulary of numbers is also imported. Nevertheless, in Tày text, this value should override kPrimaryNumeric, kAccountingNumeric, and kVietnameseNumeric if the ideograph has any of these properties.

### Shape of return

An integer.

### Notes

## kVietnameseNumeric
### Description
> The value of the character when used as a numeral in Vietnamese with Han script (Hán Nôm). It can be used alongside kPrimaryNumeric since the Chinese vocabulary of numbers is also imported in Vietnamese. Nevertheless, in Vietnamese text, this value should override kPrimaryNumeric if the character should have both properties.

### Shape of return

An integer.

### Notes

## kZhuangNumeric
### Description
> The value of the ideograph when used as a numeral in Zhuang languages with the Han script (Sawndip). It can be used alongside kPrimaryNumeric since the Chinese vocabulary of numbers is also imported in Zhuang. Nevertheless, in Zhuang text, this value should override kPrimaryNumeric if the ideograph should have both properties.

### Shape of return

An integer.

### Notes
