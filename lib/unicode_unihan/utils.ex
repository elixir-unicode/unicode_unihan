defmodule Unicode.Unihan.Utils do
  @moduledoc """
  Functions to parse the Unicode Unihand database
  files.

  """

  @doc false
  @data_dir Path.join(__DIR__, "../../data") |> Path.expand()
  def data_dir do
    @data_dir
  end

  @doc """
  Parse all Unicode Unihan files and return
  a mapping from codepoint to a map of metadata
  for that codepoint.

  """
  def parse_files do
    @data_dir
    |> Path.join("unihan")
    |> File.ls!()
    |> Enum.reduce(%{}, &parse_file(&1, &2))
  end

  @doc """
  Parse one Unicode Unihan file and return
  a mapping from codepoint to a map of metadata
  for that codepoint.

  """
  def parse_file(file, map \\ %{}) do
    path = Path.join(@data_dir, ["unihan/", file])

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

  def unihan_fields do
    @data_dir
    |> Path.join("unihan_fields.json")
    |> File.read!()
    |> Jason.decode!()
    |> Map.get("records")
    |> Enum.map(fn map ->
      fields = Map.get(map, "fields")
      {name, fields} = Map.pop(fields, "name")

      fields =
        Enum.map(fields, fn
          {"Status", status} ->
            {:status, String.downcase(status) |> String.to_atom()}
          {"delimiter", "space"} ->
            {:delimiter, "\s"}
          {"delimiter", "N/A"} ->
            {:delimiter, nil}
          {"category", category} ->
            {:category, String.downcase(category) |> String.replace(" ", "_") |> String.to_atom()}
          {"syntax", syntax} when is_binary(syntax) ->
            {:syntax, Regex.compile!(syntax, [:unicode])}
          {field, value} ->
            {String.to_atom(field), value}
        end)
        |> Map.new()

      {String.to_atom(name), fields}
    end)
    |> Map.new()
  end

  @doc """
  Decode the value of a given metadata key.
  """
  def decode_metadata(key, value) do
    {key, value}
  end
end