defmodule Unicode.Unihan.Property do
  @moduledoc false

  require Logger
  alias Unicode.Unihan.Utils

  @url "https://www.unicode.org/reports/tr38/#AlphabeticalListing"

  def download do
    case Unicode.Unihan.Http.get(@url) do
      {:ok, content} ->
        {:ok, content}

      {:error, reason} ->
        Logger.info("Failed to download #{inspect(@url)}: #{reason}")
        {:error, reason}
    end
  end

  def update! do
    case download() do
      {:ok, content} ->
        path = Path.join(Utils.data_dir(), Utils.unihan_properties_file())
        properties = parse(content)
        File.write!(path, :erlang.term_to_binary(properties))

      other ->
        other
    end
  end

  def parse do
    case download() do
      {:ok, content} ->
        parse(content)

      other ->
        other
    end
  end

  def parse(content) do
    content
    |> Floki.parse_document!()
    |> Floki.find("div.body")
    |> Floki.find("table[summary]")
    |> Enum.map(&parse_table/1)
    |> Enum.reject(&is_nil/1)
    |> Map.new()
  end

  defp parse_table({"table", [{"summary", "k" <> property} | _], rows}) do
    attributes =
      rows
      |> Enum.map(&parse_row/1)
      |> Map.new

    {String.to_atom("k" <> property), attributes}
  end

  defp parse_table(_) do
    nil
  end

  defp parse_row({"tr", [], columns}) when is_list(columns) do
    {key, value} =
      case columns do
        [{"td", _, ["Property"]}, {"td", _, [{"a", [_, {_, value}], _}]}] ->
          {"name", value}
        [{"td", _, ["Delimiter"]}, {"td", _, [value]}] ->
          {"delimiter", parse_delimiter(value)}
        [{"td", _, ["Description"]}, {"td", _, description}] ->
          {"description", parse_description(description)}
        [{"td", _, ["Category"]}, {"td", _, [value]}] ->
          {"category", Unicode.Unihan.Utils.normalize_atom(value)}
        [{"td", _, ["Status"]}, {"td", _, [value]}] ->
          {"status", Unicode.Unihan.Utils.normalize_atom(value)}
        [{"td", _, ["Syntax"]}, {"td", _, syntax}] ->
          {"syntax", parse_syntax(syntax)}
        [{"td", _, [key]}, {"td", _, [value]}] ->
          {key, value}
        [{"td", _, ["Syntax"]}, {"td", _, syntax}] ->
          {"syntax", parse_syntax(syntax)}
      end

    key =
      key
      |> String.downcase()
      |> String.to_atom()

    {key, value}
  end

  defp parse_delimiter("space") do
    " "
  end

  defp parse_delimiter("N/A") do
    nil
  end

  defp parse_description(description) when is_list(description) do
    Enum.map(description, fn
      string when is_binary(string) -> string
      {"br", [], []} -> ""
      {"a", _, [{"tt", [], [string]}]} when is_binary(string) -> string
      {"a", _, [{"code", [], [string]}]} when is_binary(string) -> string
      {"tt", _, [{"a", _, [string]}]} when is_binary(string) -> string
      {_tag, _, [string]} when is_binary(string) -> string
      {:comment, _} -> ""
    end)
    |> Enum.join()
    |> String.replace(~r/[\n\t] */, " ")
  end

  defp parse_syntax(syntax) when is_binary(syntax) do
    Regex.compile!(syntax, [:unicode])
  end

  defp parse_syntax(syntax) when is_list(syntax) do
    Enum.map(syntax, fn
      string when is_binary(string) -> string
      {"br", [], []} -> " "
    end)
    |> Enum.join()
    |> String.replace("\n", "")
    |> Regex.compile!([:unicode])
  end
end
