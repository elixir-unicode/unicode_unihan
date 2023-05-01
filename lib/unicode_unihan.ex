defmodule Unicode.Unihan do
  @moduledoc """
  Functions to introspect the Unicode Unihan character database.

  """

  @doc """
  Returns the Unihan database as a mapping
  of a codepoint to its metadata.

  """
  @unihan_data Unicode.Unihan.Utils.parse_files()
  def unihan do
    @unihan_data
  end

  @doc """
  Returns the field information for the data in the
  Unihan database.

  """
  @unihan_fields Unicode.Unihan.Utils.unihan_fields()
  def unihan_fields do
    @unihan_fields
  end

  @doc """
  Fitler the Unihan database returning selected
  codepoints.

  ### Arguments

  * `fun` is a `1-arity` function that is passed
    the attribute map for a given codepoint. if the
    function returns a `truthy` value then the codepoint
    is included in the returned data. If the return
    value is `falsy` then the codepoint is ommitted
    from the returned list.

  ### Returns

  * a map of the filtered codepoints mapped to their
    attributes.

  ### Example

      iex> Unicode.Unihan.filter(&(&1.kTotalStrokes[:"zh-Hans"] > 30))
      ...> |> Enum.count()
      238

      iex> Unicode.Unihan.filter(&(&1.kTotalStrokes[:"zh-Hans"] != &1.kTotalStrokes[:"zh-Hant"]))
      ...> |> Enum.count
      3

  """
  def filter(fun) when is_function(fun, 1) do
    Enum.filter unihan(), fn {_codepoint, value} ->
      fun.(value)
    end
  end

  @doc """
  Filter the Unihan database returning selected
  codepoints that are not rejected by the provided
  function.

  ### Arguments

  * `fun` is a `1-arity` function that is passed
    the attribute map for a given codepoint. if the
    function returns a `falsy` value then the codepoint
    is included in the returned data. If the return
    value is `truthy` then the codepoint is ommitted
    from the returned list.

  ### Returns

  * a map of the codepoints that are not rejected
    mapped to their attributes.

  ### Example

      iex> Unicode.Unihan.reject(&(&1.kTotalStrokes[:"zh-Hans"] > 30))
      ...> |> Enum.count()
      97822

  """
  def reject(fun) when is_function(fun, 1) do
    Enum.reject unihan(), fn {_codepoint, value} ->
      fun.(value)
    end
  end

end