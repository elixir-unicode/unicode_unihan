defmodule Unicode.Unihan.CantoneseTest do
  use ExUnit.Case, async: true

  alias Unicode.Unihan.Cantonese

  describe "jyutping_index/0" do
    test "returns the compiled jyutping index" do
      index = Cantonese.jyutping_index()
      assert is_map(index)
      assert Map.has_key?(index, "faan1")
    end
  end

  describe "to_jyutping/1" do
    test "decomposes a valid jyutping into its parts" do
      assert {:ok, %{onset: "h", nucleus: "aa", coda: "n", tone: "1", final: "aan"}} =
               Cantonese.to_jyutping("haan1")
    end

    test "returns an error for an invalid jyutping" do
      assert {:error, "Invalid jyutping. Found \"xxx\""} = Cantonese.to_jyutping("xxx")
    end

    test "returns an error for a non-string input" do
      assert {:error, "to_jyutping/1 requires a string as input"} = Cantonese.to_jyutping(999)
    end
  end

  describe "to_jyutping!/1" do
    test "returns the bare map for a valid jyutping" do
      assert %{jyutping: "m4"} = Cantonese.to_jyutping!("m4")
    end

    test "returns an error tuple for a non-string input" do
      assert {:error, "to_jyutping!/1 requires a string as input"} = Cantonese.to_jyutping!(999)
    end
  end

  describe "is_valid?/1" do
    test "returns true for a valid jyutping" do
      assert Cantonese.is_valid?("faan1")
      assert Cantonese.is_valid?("m4")
    end

    test "returns false for an invalid jyutping" do
      refute Cantonese.is_valid?("faaaan1")
      refute Cantonese.is_valid?("faan7")
      refute Cantonese.is_valid?("fn1")
    end

    test "returns false for a non-string input" do
      refute Cantonese.is_valid?(999)
      refute Cantonese.is_valid?(nil)
      refute Cantonese.is_valid?(:atom)
    end
  end
end
