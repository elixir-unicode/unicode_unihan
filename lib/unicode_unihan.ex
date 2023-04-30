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

end