defmodule Unicode.Unihan.DecodeTest do
  use ExUnit.Case, async: true

  # Exercises the decoders for property forms introduced or changed
  # between Unicode 15.1 and 18.0, against the shipped database.

  describe "kTotalStrokes" do
    test "decodes to an integer" do
      assert Unicode.Unihan.unihan(0x6771).kTotalStrokes == 8
    end
  end

  describe "kRSUnicode" do
    test "decodes the radical variant into :script" do
      assert [
               %{radical: 5, strokes: 10, script: :Hant, simplified_radical: false},
               %{radical: 213, strokes: 0, script: :Hanj, simplified_radical: false}
             ] = Unicode.Unihan.unihan(0x4E80).kRSUnicode

      assert [_, %{radical: 212, script: :Hanv}] = Unicode.Unihan.unihan(0x31DE5).kRSUnicode

      assert %{radical: 120, strokes: 3, script: :Hans, simplified_radical: true} =
               Unicode.Unihan.unihan(0x4336).kRSUnicode
    end
  end

  describe "kMorohashi" do
    test "decodes supplemental volume indices" do
      assert %{index: 1, supplement: true, prime: ""} = Unicode.Unihan.unihan(0x3402).kMorohashi
    end

    test "decodes a variation selector" do
      assert %{index: 72, supplement: false, variation_selector: 0xE0101} =
               Unicode.Unihan.unihan(0x3404).kMorohashi
    end
  end

  describe "kStrange" do
    test "decodes the symmetric category" do
      assert %{category: :symmetric} = Unicode.Unihan.unihan(0x56CD).kStrange
    end
  end

  describe "properties added since Unicode 15.1" do
    test "kFanqie" do
      assert Unicode.Unihan.unihan(0x6771).kFanqie == "德紅"
    end

    test "kZhuang marks non-standard readings" do
      assert %{reading: "vingq", standard: false} = Unicode.Unihan.unihan(0x2CEF4).kZhuang
    end

    test "kJapaneseNewVariant and kJapaneseOldVariant decode to code points" do
      assert Unicode.Unihan.unihan(0x842C).kJapaneseNewVariant == 0x4E07
      assert Unicode.Unihan.unihan(0x4E07).kJapaneseOldVariant == 0x842C
    end

    test "kVietnameseNumeric decodes to an integer" do
      assert Unicode.Unihan.unihan(0x53F0).kVietnameseNumeric == 2
    end
  end

  describe "kMojiJoho" do
    test "decodes serial numbers with optional variation selectors" do
      assert [%{id: "MJ022254"}, %{id: "MJ022254", variation_selector: 0xE0101} | _] =
               Unicode.Unihan.unihan(0x842C).kMojiJoho
    end
  end

  describe "kSMSZD2003Index and kSMSZD2003Readings" do
    test "decodes index positions" do
      assert %{page: 589, position: 5} = Unicode.Unihan.unihan(0x842C).kSMSZD2003Index
    end

    test "decodes mandarin and cantonese readings, keeping polysyllables as strings" do
      assert %{
               mandarin: ["cùn", "yīngcùn"],
               cantonese: [%{jyutping: "cyun3"}, "jing1cyun3"]
             } = Unicode.Unihan.unihan(0x540B).kSMSZD2003Readings
    end
  end
end
