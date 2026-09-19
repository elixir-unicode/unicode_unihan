defmodule Unicode.Unihan.UtilsTest do
  use ExUnit.Case, async: false

  alias Unicode.Unihan.Utils

  describe "path and file helpers" do
    test "data_dir/0 returns the priv directory" do
      assert File.dir?(Utils.data_dir())
    end

    test "unihan_path/0 points at the etf file" do
      assert Utils.unihan_path() =~ "unihan.etf"
    end

    test "unihan_codepoints_path/0 points at the codepoints file" do
      assert Utils.unihan_codepoints_path() =~ "unihan_codepoints.etf"
    end

    test "unihan_properties_file/0 returns the properties filename" do
      assert Utils.unihan_properties_file() == "unihan_properties.etf"
    end
  end

  describe "unihan_properties/0" do
    test "returns a map of field definitions keyed by property atom" do
      properties = Utils.unihan_properties()

      assert is_map(properties)
      assert Map.has_key?(properties, :kDefinition)
      assert Map.has_key?(properties, :kCantonese)
    end
  end

  describe "normalize_atom/1" do
    test "downcases and replaces spaces with underscores" do
      assert Utils.normalize_atom("Some Category") == :some_category
      assert Utils.normalize_atom("Provisional") == :provisional
    end
  end

  describe "parse_radicals/0" do
    test "returns radicals keyed by radical number with script variants" do
      radicals = Utils.parse_radicals()

      assert is_map(radicals)
      # Radical 1 (一)
      assert %{Hant: %{radical_number: 1}} = radicals[1]
      # Radical 187 (馬 / 马) has both traditional and simplified variants
      assert %{Hant: %{unified_ideograph: 39_340}, Hans: %{unified_ideograph: 39_532}} =
               radicals[187]

      # Radical 212 (龍) has all four variants since Unicode 18.0; the
      # Vietnamese form has no character in the radical blocks.
      assert %{Hanj: %{unified_ideograph: 0x7ADC}, Hanv: %{unified_ideograph: 0x31DE5}} =
               radicals[212]

      assert radicals[212][:Hanv][:radical_character] == nil
    end
  end

  describe "parse_cantonese/0" do
    test "returns jyutping map keyed by jyutping string" do
      index = Utils.parse_cantonese()

      assert is_map(index)
      assert %{onset: _, nucleus: _, coda: _, tone: _, final: _} = index["faan1"]
    end
  end

  describe "parse_file/1" do
    test "parses a single Unihan data file into a codepoint map" do
      map = Utils.parse_file("Unihan_NumericValues.txt")

      assert is_map(map)
      assert map_size(map) > 0

      # Each parsed codepoint carries its own :codepoint key.
      {codepoint, data} = Enum.at(map, 0)
      assert is_integer(codepoint)
      assert data.codepoint == codepoint
    end
  end

  describe "parse_files/0 (full decode of every property)" do
    @tag :slow
    test "parses the entire Unihan database exercising every decode_value clause" do
      unihan = Utils.parse_files()

      assert is_map(unihan)
      # The full database has well over 90,000 codepoints.
      assert map_size(unihan) > 90_000

      # Spot-check a known codepoint (U+9B5A 魚, fish).
      fish = unihan[0x9B5A]
      assert is_map(fish)
      assert fish.codepoint == 0x9B5A
      assert is_integer(fish.kTotalStrokes)
    end
  end
end
