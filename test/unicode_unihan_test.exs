defmodule Unicode.Test do
  use ExUnit.Case

  setup_all do
    Unicode.Unihan.load_unihan()
    :ok
  end

  doctest Unicode.Unihan
  doctest Unicode.Unihan.Cantonese
  doctest Unicode.Unihan.Radical
  doctest Unicode.Unihan.Cangjie
end
