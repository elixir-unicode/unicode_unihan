# Unicode Unihan

[![Hex.pm](https://img.shields.io/hexpm/v/unicode_unihan.svg)](https://hex.pm/packages/unicode_unihan)
[![Hex.pm](https://img.shields.io/hexpm/dw/unicode_unihan.svg?)](https://hex.pm/packages/unicode_unihan)
[![Hex.pm](https://img.shields.io/hexpm/l/unicode_unihan.svg)](https://hex.pm/packages/unicode_unihan)

Functions to return information about Unicode Unihan codepoints.

## Installation

The package can be installed by adding `unicode_unihan` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unicode_unihan, "~> 0.1"}
  ]
end
```

The docs can be found at [https://hexdocs.pm/unicode_unihan](https://hexdocs.pm/unicode_unihan).

### Usage

The function `Unicode.Unihan.load_unihan/0` must be the first function called in order to load the Unihan database into `:persistent_term`. This call can be made directly in an `iex` or `livebook` session or added to an applications `start/0` function.

## Tutorial livebooks

See the [guide to Unihan and Unihan introspection](https://raw.githubusercontent.com/elixir-unicode/unicode_unihan/main/docs/unihan_walkthrough.livemd) livebook.

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fraw.githubusercontent.com%2Felixir-unicode%2Funicode_unihan%2Fmain%2Fdocs%2Funihan_walkthrough.livemd)
