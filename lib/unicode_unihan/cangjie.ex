defmodule Unicode.Unihan.Cangjie do
  @moduledoc """
  Maps Cangjie keyboard input codes to their Chinese character parts.

  The Cangjie input method assigns each key on a Latin keyboard (A-Z) to a
  Chinese character component. This module converts those single-letter codes,
  or lists of codes, into the corresponding character parts.

  """
  @cangjie %{
    A: "日",
    B: "月",
    C: "金",
    D: "木",
    E: "水",
    F: "火",
    G: "土",
    H: "竹",
    I: "戈",
    J: "十",
    K: "大",
    L: "中",
    M: "一",
    N: "弓",
    O: "人",
    P: "心",
    Q: "手",
    R: "口",
    S: "尸",
    T: "廿",
    U: "山",
    V: "女",
    W: "田",
    X: "難",
    Y: "卜",
    Z: ""
  }

  @doc """
  Returns the full map of Cangjie input codes to character parts.

  ### Returns

  * a map of uppercase code atoms (`:A`..`:Z`) to their character part strings.

  ### Examples

      iex> Unicode.Unihan.Cangjie.cangjies()[:A]
      "日"

  """
  def cangjies do
    @cangjie
  end

  @doc """
  Converts a single Cangjie keyboard code into its Chinese character part.

  ### Arguments

  * `value` is a single-letter binary (`"A"`..`"Z"`, case-insensitive).

  ### Returns

  * `{:ok, part}` where `part` is the character part string for a valid code.

  * `{:error, message}` if the input is not a single A-Z letter, or is not a binary.

  ### Examples

      iex> Unicode.Unihan.Cangjie.cangjie("U")
      {:ok, "山"}

      iex> Unicode.Unihan.Cangjie.cangjie("1")
      {:error, "Cangjie inputs must be alphabets A-Z"}

  """
  def cangjie(value) when is_binary(value) do
    case value |> String.graphemes() |> length() == 1 and
           Regex.match?(~r/[A-Z]/, String.upcase(value)) do
      true -> {:ok, Map.get(cangjies(), value |> String.upcase() |> String.to_atom())}
      false -> {:error, "Cangjie inputs must be alphabets A-Z"}
    end
  end

  def cangjie(_not_string) do
    {:error, "Cangjie inputs must be a binary"}
  end

  @doc """
  Converts a Cangjie code, or a list of codes, into its character part.

  Raises if any input is not a valid code.

  ### Arguments

  * `value` is a single-letter binary (`"A"`..`"Z"`), or a list of such binaries.

  ### Returns

  * the character part string, or a list of character part strings.

  ### Examples

      iex> Unicode.Unihan.Cangjie.cangjie!("U")
      "山"

      iex> Unicode.Unihan.Cangjie.cangjie!(["U", "J"])
      ["山", "十"]

  """
  def cangjie!(list) when is_list(list) do
    Enum.map(list, &cangjie!/1)
  end

  def cangjie!(value) do
    {:ok, result} = cangjie(value)
    result
  end
end
