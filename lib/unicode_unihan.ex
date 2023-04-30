defmodule Unicode.Unihan do
  @moduledoc """
  Functions to introspect the Unicode Unihan character database.

  """

  @doc """
  Returns the Unihan database as a mapping
  of a codepoint to its metadata.

  """
  @unihan_data Unicode.Unihan.Utils.parse_files()
  def unihan_metadata do
    @unihan_data
  end
end