defmodule Unicode.Unihan.Cangjie do
  @moduledoc """
  Allow easy interconversion of keyboard input and character.
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

  def cangjies do
    @cangjie
  end
  @doc """
  Converts an alphabet keyboard input to the Chinese Cangjie part.  Returns an OK tuple.

      ## Example

      iex> Unicode.Unihan.Cangjie.cangjie("U")
      {:ok, "山"}
  """
  def cangjie(value) when is_binary(value) do
    case value |> String.graphemes |> length() == 1 and Regex.match?(~r/[A-Z]/, String.upcase(value)) do
      true  -> {:ok, Map.get(cangjies(), value |> String.upcase |> String.to_atom)}
      false -> {:error, "Cangjie inputs must be alphabets A-Z"}
    end
  end

  def cangjie(_not_string) do
    {:error, "Cangjie inputs must be a binary"}
  end

  @doc """
  Converts an alphabet keyboard input, or a list of alphabet keyboard inputs, to the Chinese Cangjie part. Throws exception if invalid input is supplied.

      ## Example

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
