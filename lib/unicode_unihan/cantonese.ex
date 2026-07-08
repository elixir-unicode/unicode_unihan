defmodule Unicode.Unihan.Cantonese do
  @moduledoc """
  `Unicode.Unihan.Cantonese` acts on pronunciations as a simple string
  (e.g., "faan1", "gwai3"), and provides functions to decompose these
  into standard structs as well as checking their validity.

  """

  @doc """
  Returns the compiled index of every valid jyutping pronunciation.

  ### Returns

  * a map keyed by jyutping string, each mapped to its decomposed pronunciation map.

  ### Examples

      iex> index = Unicode.Unihan.Cantonese.jyutping_index()
      ...> index["haan1"]
      %{onset: "h", nucleus: "aa", coda: "n", tone: "1", final: "aan", jyutping: "haan1"}

  """
  @jyutping_index Unicode.Unihan.Utils.parse_cantonese()
  def jyutping_index do
    @jyutping_index
  end

  @doc """
  Decomposes a jyutping pronunciation string into its parts.

  The valid pronunciations are enumerated at compile time. If the input does
  not match any known pronunciation it is invalid and an error tuple is returned.

  ### Arguments

  * `jyutping` is a jyutping pronunciation string, for example `"faan1"`.

  ### Returns

  * `{:ok, map}` where `map` contains the `:onset`, `:nucleus`, `:coda`, `:tone`, `:final` and `:jyutping` keys.

  * `{:error, message}` if the string is not a valid jyutping, or the input is not a string.

  ### Examples

      iex> Unicode.Unihan.Cantonese.to_jyutping("haan1")
      {:ok, %{onset: "h", nucleus: "aa", coda: "n", tone: "1", final: "aan", jyutping: "haan1"}}

      iex> Unicode.Unihan.Cantonese.to_jyutping("xxx")
      {:error, "Invalid jyutping. Found \\"xxx\\""}

      iex> Unicode.Unihan.Cantonese.to_jyutping(999)
      {:error, "to_jyutping/1 requires a string as input"}

  """
  def to_jyutping(jyutping) when is_binary(jyutping) do
    case Map.fetch(jyutping_index(), jyutping) do
      {:ok, result} -> {:ok, result}
      :error -> {:error, "Invalid jyutping. Found #{inspect(jyutping)}"}
    end
  end

  def to_jyutping(_not_string) do
    {:error, "to_jyutping/1 requires a string as input"}
  end

  @doc """
  Decomposes a jyutping pronunciation string, returning the bare parts map.

  ### Arguments

  * `jyutping` is a jyutping pronunciation string, for example `"faan1"`.

  ### Returns

  * the decomposed pronunciation map for a valid jyutping.

  * `{:error, message}` if the input is not a string. A non-string input returns an error tuple rather than raising.

  ### Examples

      iex> Unicode.Unihan.Cantonese.to_jyutping!("haan1")
      %{onset: "h", nucleus: "aa", coda: "n", tone: "1", final: "aan", jyutping: "haan1"}

      iex> Unicode.Unihan.Cantonese.to_jyutping!("m4")
      %{onset: "", nucleus: "m", coda: "", tone: "4", final: "m", jyutping: "m4"}

  """
  def to_jyutping!(jyutping) when is_binary(jyutping) do
    {:ok, result} = to_jyutping(jyutping)
    result
  end

  def to_jyutping!(_not_string) do
    {:error, "to_jyutping!/1 requires a string as input"}
  end

  @doc """
  Returns `true` if the jyutping is validly constructed.

  This checks structural validity only; it does not state anything about the
  pronunciation's usage in the language.

  ### Arguments

  * `jyutping` is a jyutping pronunciation string, for example `"faan1"`.

  ### Returns

  * `true` if the string is a valid jyutping, otherwise `false`. A non-string input returns `false`.

  ### Examples

      iex> Unicode.Unihan.Cantonese.is_valid?("faan1")
      true

      iex> Unicode.Unihan.Cantonese.is_valid?("m4")
      true

      iex> Unicode.Unihan.Cantonese.is_valid?("lan1")
      true

      iex> Unicode.Unihan.Cantonese.is_valid?("faaaan1")
      false

      iex> Unicode.Unihan.Cantonese.is_valid?("faan7")
      false

      iex> Unicode.Unihan.Cantonese.is_valid?("fn1")
      false

  """

  # `is_valid?/1` is part of the published public API; renaming it to `valid?/1`
  # would be a breaking change, so the `is_` prefix is retained deliberately.
  # credo:disable-for-next-line Credo.Check.Readability.PredicateFunctionNames
  def is_valid?(jyutping) when is_binary(jyutping) do
    Map.has_key?(jyutping_index(), jyutping)
  end

  # credo:disable-for-next-line Credo.Check.Readability.PredicateFunctionNames
  def is_valid?(_not_string), do: false
end
