defmodule Unicode.Unihan do
  @moduledoc """
  Functions to introspect the Unicode Unihan character database.

  """
  @doc false
  @data_dir Path.join(__DIR__, "../data") |> Path.expand()
  def data_dir do
    @data_dir
  end

end