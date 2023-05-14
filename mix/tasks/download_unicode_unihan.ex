defmodule Mix.Tasks.Unicode.Unihan.Download do
  @moduledoc """
  Downloads the required Unicode Unihan database to support
  Unihan introspection.
  """

  use Mix.Task
  require Logger

  @shortdoc "Download Unicode Unihan database"

  @root_url "https://www.unicode.org/Public/UCD/latest/ucd/"

  @download_dir Unicode.Unihan.Utils.data_dir() |> Path.expand()

  @doc false
  def run(_) do
    Application.ensure_all_started(:inets)
    Application.ensure_all_started(:ssl)

    Enum.each(required_files(), &download_file/1)
    extract_unihan_database!()
  end

  defp required_files do
    [
      {Path.join(root_url(), "/Unihan.zip"), data_path("unihan.zip")},
      {Path.join(root_url(), "/CJKRadicals.txt"), data_path("cjk_radicals.txt")}
    ]
  end

  def extract_unihan_database! do
    extract_dir = Path.join(@download_dir, "unihan")

    data_path("unihan.zip")
    |> String.to_charlist()
    |> :zip.extract(cwd: String.to_charlist(extract_dir))

    File.rm!(data_path("unihan.zip"))
  end

  def root_url do
    @root_url
  end

  defp download_file({url, destination}) do
    url = String.to_charlist(url)

    case :httpc.request(:get, {url, headers()}, https_opts(), []) do
      {:ok, {{_version, 200, 'OK'}, _headers, body}} ->
        destination
        |> File.write!(:erlang.list_to_binary(body))

        Logger.info("Downloaded #{inspect(url)} to #{inspect(destination)}")
        {:ok, destination}

      {_, {{_version, code, message}, _headers, _body}} ->
        Logger.error(
          "Failed to download #{inspect(url)}. " <> "HTTP Error: (#{code}) #{inspect(message)}"
        )

        {:error, code}

      {:error, {:failed_connect, [{_, {host, _port}}, {_, _, sys_message}]}} ->
        Logger.error(
          "Failed to connect to #{inspect(host)} to download " <>
            " #{inspect(url)}. Reason: #{inspect(sys_message)}"
        )

        {:error, sys_message}
    end
  end

  defp headers do
    []
  end

  @certificate_locations [
                           # Configured cacertfile
                           Application.compile_env(:unicode, :cacertfile),

                           # Populated if hex package CAStore is configured
                           if(Code.ensure_loaded?(CAStore), do: CAStore.file_path()),

                           # Populated if hex package certfi is configured
                           if(Code.ensure_loaded?(:certifi),
                             do: :certifi.cacertfile() |> List.to_string()
                           ),

                           # Debian/Ubuntu/Gentoo etc.
                           "/etc/ssl/certs/ca-certificates.crt",

                           # Fedora/RHEL 6
                           "/etc/pki/tls/certs/ca-bundle.crt",

                           # OpenSUSE
                           "/etc/ssl/ca-bundle.pem",

                           # OpenELEC
                           "/etc/pki/tls/cacert.pem",

                           # CentOS/RHEL 7
                           "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem",

                           # Open SSL on MacOS
                           "/usr/local/etc/openssl/cert.pem",

                           # MacOS & Alpine Linux
                           "/etc/ssl/cert.pem"
                         ]
                         |> Enum.reject(&is_nil/1)

  def certificate_store do
    @certificate_locations
    |> Enum.find(&File.exists?/1)
    |> raise_if_no_cacertfile
    |> :erlang.binary_to_list()
  end

  defp raise_if_no_cacertfile(nil) do
    raise RuntimeError, """
    No certificate trust store was found.
    Tried looking for: #{inspect(@certificate_locations)}

    A certificate trust store is required in
    order to download locales for your configuration.

    Since no system installed certificate trust store
    could be found, one of the following actions may be
    taken:

    1. Install the hex package `castore`. It will
       be automatically detected after recompilation.

    2. Install the hex package `certifi`. It will
       be automatically detected after recomilation.

    3. Specify the location of a certificate trust store
       by configuring it in `config.exs`:

       config :unicode,
         cacertfile: "/path/to/cacertfile",
         ...

    """
  end

  defp raise_if_no_cacertfile(file) do
    file
  end

  defp https_opts do
    [
      ssl: [
        verify: :verify_peer,
        cacertfile: certificate_store(),
        customize_hostname_check: [
          match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
        ]
      ]
    ]
  end

  defp data_path(filename) do
    Path.join(@download_dir, filename)
  end
end
