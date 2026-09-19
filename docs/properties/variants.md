# Variants

## kJapaneseNewVariant
### Description
> The Unicode value for the new Japanese form (新字体) of this ideograph.

### Shape of return

An integer code point:

```elixir
38971
```

### Notes

## kJapaneseOldVariant
### Description
> One or more Unicode values for the old Japanese forms (旧字体) of this ideograph.

### Shape of return

An integer code point, or a list of them:

```elixir
33287
```

### Notes

## kSemanticVariant
### Description
> The Unicode value for a semantic variant for this ideograph. A semantic variant is an x- or y-variant with similar or identical meaning which can generally be used in place of the indicated ideograph. Also see Section 3.7.2.

> The basic syntax is a Unicode Scalar Value. It may optionally be followed by additional data. The additional data is separated from the Unicode Scalar Value by a less-than sign (<), and may be subdivided itself into substrings by commas, each of which may be divided into two pieces by a colon. The additional data consists of a series of property tags for another property in the Unihan database indicating the source of the information. If these property tags are themselves subdivided by a colon, the final piece is a string consisting of the letters T (for tòng, U+540C 同) B (for bù, U+4E0D 不), Z (for zhèng, U+6B63 正), F (for fán, U+7E41 繁), or J (for jiǎnU+7C21 簡/U+7B80 简).

> T is used if the indicated source explicitly indicates the two are the same (for example, by saying that the one ideograph is “the same as” the other).

> B is used if the source explicitly indicates that the two are used improperly one for the other.

> Z is used if the source explicitly indicates that the given ideograph is the preferred form. Thus, kHanYu indicates that U+5231 刱 and U+5275 創 are semantic variants and that U+5275 創 is the preferred form.

> F is used if the source explicitly indicates that the given ideograph is the traditional form.

> J is used if the source explicitly indicates that the given ideograph is the simplified form.

> Data on simplified and traditional variations can be included in this property to document cases where different sources disagree on the nature of the relationship between two ideographs. The kSemanticVariant and kSpecializedSemanticVariant properties need not be consulted when interconverting between traditional and simplified Chinese.

> As an example, U+3A17 㨗 has the kSemanticVariant value "U+6377<kHanYu:TZ". This means that, according to the Hanyu Da Zidian, U+3A17 㨗 and U+6377 捷 have identical meaning and that U+6377 捷 is the preferred form.

### Shape of return

### Notes

## kSimplifiedVariant
### Description
> The Unicode value(s) for the simplified Chinese variant(s) for this ideograph. A full discussion of the kSimplifiedVariant and kTraditionalVariant properties is found in Section 3.7.1 above.

> Much of the data on simplified and traditional variants was graciously supplied by Wenlin Institute, Inc.

### Shape of return

### Notes

## kSpecializedSemanticVariant
### Description
> The Unicode value for a specialized semantic variant for this ideograph. The syntax is the same as for the kSemanticVariant property.

> A specialized semantic variant is an x- or y-variant with similar or identical meaning only in certain contexts. See Section 3.7.2 for a full description.

### Shape of return

### Notes

## kSpoofingVariant
### Description
> The spoofing variants for the ideograph, if any. Spoofing variants include ideograph pairs which look similar, particularly at small point sizes, which are not already z-variants or compatibility variants. See Section 3.7.3 for a full description of spoofing variants. The syntax consists of the ideograph’s code point.

### Shape of return

### Notes

## kTraditionalVariant
### Description
> The Unicode value(s) for the traditional Chinese variant(s) for this ideograph. A full discussion of the kSimplifiedVariant and kTraditionalVariant properties is found in Section 3.7.1 above.

> Much of the data on simplified and traditional variants was graciously supplied by Wenlin Institute, Inc.

### Shape of return

### Notes

## kZVariant
### Description
> The z-variants for the ideograph, if any. Z-variants are instances where the same abstract shape has been encoded multiple times, either in error or because of the now-abolished Source Separation Rule. Z-variant pairs also have identical semantics.

> The basic syntax is a Unicode Scalar Value. It may optionally be followed by additional data. The additional data is separated from the Unicode Scalar Value by a less-than sign (<), and may be subdivided itself into substrings by commas. The additional data consists of a series of property tags for another property in the Unihan database indicating the source of the information.

### Shape of return

### Notes
