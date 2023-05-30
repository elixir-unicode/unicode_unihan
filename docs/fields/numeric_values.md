# Numeric values

## kAccountingNumeric
### Description
> The value of the character when used as an accounting numeral to prevent fraud. A numeral such as 十 (ten) is easily transformed into 千 (thousand) by adding a single stroke, so monetary documents often use an accounting form of the numeral, such as 拾 (ten), instead of the more common—and simpler—form. Characters with this property will have a single, well-defined value, which a native reader can reasonably be expected to understand.

> The three numeric-value fields should have no overlap; that is, characters with a `kAccountingNumeric` value should not have a `kOtherNumeric` or `kPrimaryNumeric` value as well.

### Shape of return

### Notes

## kOtherNumeric
### Description
> One or more values of the character when used as a numeral. Characters with this property are rarely used for writing numbers, or have non-standard or multiple values depending on the region. For example, 㠪 is a rare character whose meaning, “five,” would not be recognized by most native readers. An English-language equivalent is “gross,” whose numeric value, “one hundred forty-four,” is not universally understood by native readers.

> The three numeric-value fields should have no overlap; that is, characters with a `kOtherNumeric` value should not have a `kAccountingNumeric` or `kPrimaryNumeric` value as well.

### Shape of return

### Notes

## kPrimaryNumeric
### Description
> The value of the character when used as a numeral. Characters which have this property have numeric values that are common, and always convey the same numeric value. For example, 千 always means “thousand.” A native reader is expected to understand the numeric value for these characters.

> The three numeric-value fields should have no overlap; that is, characters with a `kPrimaryNumeric` value should not have a `kAccountingNumeric` or `kOtherNumeric` value as well.

### Shape of return

### Notes
