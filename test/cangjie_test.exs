defmodule Unicode.Unihan.CangjieTest do
  use ExUnit.Case, async: true

  alias Unicode.Unihan.Cangjie

  describe "cangjies/0" do
    test "returns the full cangjie mapping" do
      assert %{A: "日", Z: ""} = Cangjie.cangjies()
    end
  end

  describe "cangjie/1" do
    test "converts an uppercase letter to its cangjie part" do
      assert Cangjie.cangjie("U") == {:ok, "山"}
    end

    test "converts a lowercase letter (case-insensitive)" do
      assert Cangjie.cangjie("u") == {:ok, "山"}
    end

    test "returns an error for a non-alphabetic input" do
      assert Cangjie.cangjie("1") == {:error, "Cangjie inputs must be alphabets A-Z"}
    end

    test "returns an error for a multi-character input" do
      assert Cangjie.cangjie("AB") == {:error, "Cangjie inputs must be alphabets A-Z"}
    end

    test "returns an error for a non-binary input" do
      assert Cangjie.cangjie(123) == {:error, "Cangjie inputs must be a binary"}
    end
  end

  describe "cangjie!/1" do
    test "returns the bare cangjie part for a single letter" do
      assert Cangjie.cangjie!("U") == "山"
    end

    test "maps over a list of letters" do
      assert Cangjie.cangjie!(["U", "J"]) == ["山", "十"]
    end
  end
end
