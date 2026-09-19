defmodule Unicode.Unihan.ApiTest do
  use ExUnit.Case, async: false

  setup_all do
    Unicode.Unihan.load_unihan()
    :ok
  end

  describe "unihan/1" do
    test "looks up by integer codepoint" do
      assert %{codepoint: 14_192} = Unicode.Unihan.unihan(14_192)
    end

    test "looks up by grapheme" do
      assert %{codepoint: 14_192} = Unicode.Unihan.unihan("㝰")
    end

    test "looks up by 4-digit U+ notation" do
      assert %{codepoint: 0x9B5A} = Unicode.Unihan.unihan("U+9B5A")
    end

    test "looks up by 6-digit U+ notation" do
      result = Unicode.Unihan.unihan("U+29D4B")
      assert is_map(result)
      assert result.codepoint == 0x29D4B
    end

    test "returns nil for an unassigned codepoint" do
      # U+0041 (Latin 'A') is not a Han character.
      assert Unicode.Unihan.unihan(0x41) == nil
    end
  end

  describe "to_string/1" do
    test "converts an integer codepoint to a grapheme" do
      assert Unicode.Unihan.to_string(25_342) == "拾"
    end

    test "converts a unihan map to a grapheme" do
      assert 25_342 |> Unicode.Unihan.unihan() |> Unicode.Unihan.to_string() == "拾"
    end

    test "converts a list of unihan maps to a list of graphemes" do
      maps = [Unicode.Unihan.unihan(25_342), Unicode.Unihan.unihan(14_192)]
      assert Unicode.Unihan.to_string(maps) == ["拾", "㝰"]
    end
  end

  describe "filter/1 and reject/1" do
    test "filter/1 selects codepoints matching the predicate" do
      count =
        Unicode.Unihan.filter(&(&1.kTotalStrokes > 30))
        |> Enum.count()

      assert count == 258
    end

    test "reject/1 excludes codepoints matching the predicate" do
      filtered = Unicode.Unihan.filter(&(&1.kTotalStrokes > 30)) |> Enum.count()
      rejected = Unicode.Unihan.reject(&(&1.kTotalStrokes > 30)) |> Enum.count()

      # filter and reject partition the codepoints that carry kTotalStrokes.
      assert rejected > filtered
    end
  end

  describe "unihan_properties/0" do
    test "returns the compiled property metadata" do
      properties = Unicode.Unihan.unihan_properties()
      assert is_map(properties)
      assert Map.has_key?(properties, :kCantonese)
    end
  end

  describe "lazy loading" do
    test "unihan/1 reloads the database when the cached term has been cleared" do
      # Simulate a cold process: drop the cached codepoint and index so the
      # lazy-load path (maybe_load_unihan/1 and unihan_codepoints/0) runs.
      :persistent_term.erase({:unihan, 14_192})
      :persistent_term.erase(:unihan_codepoints)

      assert %{codepoint: 14_192} = Unicode.Unihan.unihan(14_192)
    end

    test "filter/1 reloads the codepoint index when it has been cleared" do
      :persistent_term.erase(:unihan_codepoints)

      count = Unicode.Unihan.filter(&(&1.kTotalStrokes > 30)) |> Enum.count()
      assert count == 258
    end
  end
end
