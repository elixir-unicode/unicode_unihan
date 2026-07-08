defmodule Unicode.Unihan.RadicalTest do
  use ExUnit.Case, async: true

  alias Unicode.Unihan.Radical

  describe "radicals/0" do
    test "returns the full radical map" do
      radicals = Radical.radicals()
      assert is_map(radicals)
      assert Map.has_key?(radicals, 1)
    end
  end

  describe "radical/2" do
    test "returns the traditional unified ideograph by default" do
      assert Radical.radical(187) == "馬"
    end

    test "returns the simplified glyph when script: :Hans" do
      assert Radical.radical(187, script: :Hans) == "马"
    end

    test "returns the radical character glyph" do
      assert Radical.radical(187, script: :Hant, glyph: :radical_character) == "⾺"
    end

    test "returns a Japanese variant glyph" do
      assert Radical.radical(213, script: :Hanj) == "亀"
    end

    test "returns the full map with :all" do
      assert %{Hant: %{radical_number: 187}, Hans: %{radical_number: 187}} =
               Radical.radical(187, :all)
    end

    test "returns an error tuple for an out-of-range radical number" do
      assert {:error, message} = Radical.radical(999)
      assert message =~ "Invalid radical number"
    end

    test "returns an error tuple for a non-integer radical number" do
      assert {:error, message} = Radical.radical("x")
      assert message =~ "Invalid radical number"
    end
  end

  describe "filter/1 and reject/1" do
    test "filter/1 selects radicals matching the predicate" do
      count =
        Radical.filter(&(&1[:Hant][:radical_number] < 5))
        |> Enum.count()

      assert count == 4
    end

    test "reject/1 excludes radicals matching the predicate" do
      count =
        Radical.reject(&(&1[:Hant][:radical_number] < 5))
        |> Enum.count()

      assert count == 210
    end
  end
end
