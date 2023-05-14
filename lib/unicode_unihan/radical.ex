defmodule Unicode.Unihan.Radical do
  @moduledoc """
  `Unicode.Unihan.Radical` encapsulates the mapping from CJK radical numbers
  to characters.

  """
  alias Unicode.Unihan.Utils

  @external_resource Path.join(Utils.data_dir(), "cjk_radicals.txt")
  @radicals Unicode.Unihan.Utils.parse_radicals()

  def radicals do
    @radicals
  end

end