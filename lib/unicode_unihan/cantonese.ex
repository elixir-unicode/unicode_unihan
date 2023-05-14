defmodule Unicode.Unihan.Cantonese do
  @moduledoc """
  `Unicode.Unihan.Cantonese` acts on pronunciations as a simple string (e.g., "faan1", "gwai3"), and provides functions to decompose these into standard structs as well as checking their validity.
  """

  @external_resource index_path = "./data/cantonese/jyutping_index.csv" |> Path.expand

  jyutping_index =
    index_path
    |> File.stream!([:trim_bom])
    |> CSV.decode!(headers: true)
    |> Enum.map(fn %{"onset" => onset, "nucleus" => nucleus, "coda" => coda, "tone" => tone, "jyutping" => jyutping} ->
      %{onset: onset, nucleus: nucleus, coda: coda, tone: tone, final: nucleus <> coda, jyutping: jyutping}
    end)

  @doc """
  Returns a :ok tuple with a struct of the string containing the jyutping split into a map with onset, nucleus, coda, tone, final, and jyutping as keys.

  The collection of functions is generated at compile time, with one for each row representing a possible pronunciation.  If the input does not match any of the exhaustive enumerations, it is invalid, and an error tuple is returned.

  ## Examples
      iex> Unicode.Unihan.Cantonese.to_jyutping!("haan1")
      %{onset: "h", nucleus: "aa", coda: "n", tone: "1", final: "aan", jyutping: "haan1"}

      iex> Unicode.Unihan.Cantonese.to_jyutping!("ngaang6")
      %{onset: "ng", nucleus: "aa", coda: "ng", tone: "6", final: "aang", jyutping: "ngaang6"}

      iex> Unicode.Unihan.Cantonese.to_jyutping!("m4")
      %{onset: "", nucleus: "m", coda: "", tone: "4", final: "m", jyutping: "m4"}

      iex> Unicode.Unihan.Cantonese.to_jyutping("xxx")
      {:error, "xxx is not a valid jyutping"}

      iex> Unicode.Unihan.Cantonese.to_jyutping(999)
      {:error, "to_jyutping() requires a string as input"}
  """

  for entry <- jyutping_index do
    def to_jyutping(unquote(entry.jyutping)), do:
      {:ok,
        %{
          onset:    unquote(entry.onset),
          nucleus:  unquote(entry.nucleus),
          coda:     unquote(entry.coda),
          tone:     unquote(entry.tone),
          final:    unquote(entry.final),
          jyutping: unquote(entry.jyutping)
        }
      }

    def to_jyutping!(unquote(entry.jyutping)) do
      {:ok, result} = to_jyutping(unquote(entry.jyutping))
      result
    end
  end

  def to_jyutping(no_match) when is_binary(no_match), do:
    {:error, "#{no_match} is not a valid jyutping"}
  def to_jyutping(_not_string), do:
    {:error, "to_jyutping() requires a string as input"}

  @doc """
  Returns true if the jyutping is validly constructed.  This does not state anything about their usage in the language.

  ## Examples
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
  for entry <- jyutping_index do
    def is_valid?(unquote(entry.jyutping)), do: true
  end
  def is_valid?(str) when is_binary(str), do: false
end
