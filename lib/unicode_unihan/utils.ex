defmodule Unicode.Unihan.Utils do
  @moduledoc """
  Functions to parse the Unicode Unihand database
  files.

  """

  @doc """
  Parse all Unicode Unihan files and return
  a mapping from codepoint to a map of metadata
  for that codepoint.

  """
  def parse_files do
    Unicode.Unihan.data_dir()
    |> File.ls!()
    |> Enum.reduce(%{}, &parse_file(&1, &2))
  end

  @doc """
  Parse one Unicode Unihan file and return
  a mapping from codepoint to a map of metadata
  for that codepoint.

  """
  def parse_file(file, map \\ %{}) do
    path =
      Unicode.Unihan.data_dir()
      |> Path.join(file)

    Enum.reduce File.stream!(path), map, fn line, map ->
      case line do
        <<"#", _rest::bitstring>> ->
          map

        <<"\n", _rest::bitstring>> ->
          map

        data ->
          [codepoint, key, value] =
            data
            |> String.split("\t")
            |> Enum.map(&String.trim/1)

          codepoint = decode_codepoint(codepoint)

          Map.get_and_update(map, codepoint, fn
            nil ->
              {key, value} = decode_metadata(key, value)
              {nil, %{String.to_atom(key) => value}}

            current_value when is_map(current_value)->
              {key, value} = decode_metadata(key, value)
              {current_value, Map.put(current_value, String.to_atom(key), value)}
          end)
          |> elem(1)
      end
    end
  end

  @doc """
  Convert a "U+xxxx" codepoint into an integer
  """
  def decode_codepoint("U+" <> codepoint) do
    String.to_integer(codepoint, 16)
  end

  @doc """
  Decode the value of a given metadata key.
  """
  def decode_metadata("kCantonese" = key, value) do
    {key, value}
  end

  def decode_metadata("kCangjie" = key, value) do
    {key, value}
  end

  def decode_metadata(key, value) do
    {key, value}
  end
end