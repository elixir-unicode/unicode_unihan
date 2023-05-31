defmodule Unicode.Unihan.MixProject do
  use Mix.Project

  @version "0.2.0"

  def project do
    [
      app: :unicode_unihan,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      name: "Unicode",
      source_url: "https://github.com/elixir-unicode/unicode_unihan",
      description: description(),
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env()),
      dialyzer: [
        plt_add_apps: ~w(mix inets public_key)a,
        ignore_warnings: ".dialyzer_ignore_warnings"
      ]
    ]
  end

  defp description do
    """
    Functions to introspect the Unicode Unihan character database.
    """
  end

  defp package do
    [
      maintainers: ["Kip Cole", "Jon Chui"],
      licenses: ["Apache-2.0"],
      logo: "logo.png",
      links: links(),
      files: [
        "lib",
        "docs",
        "data/cantonese/",
        "data/unihan/",
        "data/*.txt",
        "data/*.json",
        "logo.png",
        "mix.exs",
        "README*",
        "CHANGELOG*",
        "LICENSE*"
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :public_key, :inets]
    ]
  end

  defp deps do
    [
      {:csv, "~> 3.0"},
      {:jason, "~> 1.0"},
      {:benchee, "~> 1.0", only: :dev, optional: true},
      {:ex_doc, "~> 0.24", only: [:dev, :release], runtime: false, optional: true},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false, optional: true}
    ]
  end

  def links do
    %{
      "GitHub" => "https://github.com/elixir-unicode/unicode_unihan",
      "Readme" => "https://github.com/elixir-unicode/unicode_unihan/blob/v#{@version}/README.md",
      "Changelog" =>
        "https://github.com/elixir-unicode/unicode_unihan/blob/v#{@version}/CHANGELOG.md"
    }
  end

  def docs do
    [
      source_ref: "v#{@version}",
      main: "readme",
      logo: "logo.png",
      extras: [
        "README.md",
        "docs/fields/fields.md",
        "docs/fields/dictionary_indices.md",
        "docs/fields/dictionary_like_data.md",
        "docs/fields/irg_sources.md",
        "docs/fields/numeric_values.md",
        "docs/fields/other_mappings.md",
        "docs/fields/radical_stroke_counts.md",
        "docs/fields/readings.md",
        "docs/fields/variants.md",
        "LICENSE.md",
        "CHANGELOG.md",
      ],
      formatters: ["html"],
      groups_for_extras: [
        "Fields": Path.wildcard("docs/fields/*.md")
      ],
      skip_undefined_reference_warnings_on: ["changelog", "CHANGELOG.md"]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "mix", "src", "test"]
  defp elixirc_paths(:dev), do: ["lib", "mix", "src", "bench"]
  defp elixirc_paths(_), do: ["lib", "src"]
end
