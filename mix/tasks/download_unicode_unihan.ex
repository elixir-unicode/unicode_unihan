defmodule Mix.Tasks.Unicode.Unihan.Download do
  @moduledoc """
  Downloads the required Unicode Unihan database to support
  Unihan introspection.

  """

  use Mix.Task
  require Logger

  alias Unicode.Unihan.Utils

  @shortdoc "Download Unicode Unihan database"

  @root_url "https://www.unicode.org/Public/UCD/latest/ucd/"

  @download_dir Utils.data_dir() |> Path.expand()

  @doc false
  def run(_) do
    Application.ensure_all_started(:inets)
    Application.ensure_all_started(:ssl)

    Logger.info("Downloading the Unihan database")
    Enum.each(required_files(), &download_file/1)

    Logger.info("Extracting and saving the Unihan database")
    extract_unihan_database!()
    Utils.save_unihan!()

    Logger.info("Extracting Unihan properties")
    Unicode.Unihan.Property.update!()

    Logger.info("Completed updating the Unihan dataase")
    :ok
  end

  defp required_files do
    [
      {Path.join(root_url(), "/Unihan.zip"), data_path("unihan.zip")},
      {Path.join(root_url(), "/CJKRadicals.txt"), data_path("cjk_radicals.txt")}
    ]
  end

  defp extract_unihan_database! do
    extract_dir = Path.join(@download_dir, "unihan")

    data_path("unihan.zip")
    |> String.to_charlist()
    |> :zip.extract(cwd: String.to_charlist(extract_dir))

    File.rm!(data_path("unihan.zip"))
  end

  defp download_file({url, destination}) do
    case Unicode.Unihan.Http.get(url) do
      {:ok, content} ->
        File.write!(destination, :erlang.list_to_binary(content))
        {:ok, destination}

      {:error, reason} ->
        Logger.info("Failed to download #{inspect(url)}: #{reason}")
        {:error, reason}
    end
  end

  defp root_url do
    @root_url
  end

  defp data_path(filename) do
    Path.join(@download_dir, filename)
  end
end
