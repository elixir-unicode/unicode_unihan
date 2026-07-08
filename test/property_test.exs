defmodule Unicode.Unihan.PropertyTest do
  use ExUnit.Case, async: true

  alias Unicode.Unihan.Property

  # A compact HTML fragment mirroring the structure of the Unicode TR38
  # "Alphabetical Listing" page. Tags are kept adjacent (no inter-tag
  # whitespace between table/tr/td) so the row lists match the parser's
  # exact tuple patterns.
  @html """
  <html><body><div class="body">\
  <table summary="kExample">\
  <tr><td>Property</td><td><a name="kExample" href="kExample">kExample</a></td></tr>\
  <tr><td>Delimiter</td><td>space</td></tr>\
  <tr><td>Description</td><td>Plain text <br>and <a href="x"><tt>tt-ref</tt></a> and \
  <a href="y"><code>code-ref</code></a> and <tt><a href="z">tt-a-ref</a></tt> and \
  <b>bold</b><!-- a comment --></td></tr>\
  <tr><td>Category</td><td>Dictionary Indices</td></tr>\
  <tr><td>Status</td><td>Provisional</td></tr>\
  <tr><td>Syntax</td><td>[A-Z]<br>[0-9]+</td></tr>\
  <tr><td>Uses</td><td>some free text</td></tr>\
  </table>\
  <table summary="notaproperty"><tr><td>ignored</td><td>ignored</td></tr></table>\
  </div></body></html>
  """

  describe "parse/1" do
    test "parses a property definition table into a map" do
      result = Property.parse(@html)

      assert %{kExample: attributes} = result
      # Only the k-prefixed table is retained; the other is dropped.
      assert map_size(result) == 1

      assert attributes.name == "kExample"
      assert attributes.delimiter == " "
      assert attributes.category == :dictionary_indices
      assert attributes.status == :provisional
      assert attributes.uses == "some free text"
    end

    test "extracts the description text across nested markup" do
      %{kExample: attributes} = Property.parse(@html)

      description = attributes.description
      assert is_binary(description)
      assert description =~ "Plain text"
      assert description =~ "tt-ref"
      assert description =~ "code-ref"
      assert description =~ "bold"
    end

    test "compiles the syntax cell into a regex" do
      %{kExample: attributes} = Property.parse(@html)

      # The <br> in the syntax cell becomes a space, yielding "[A-Z] [0-9]+".
      assert %Regex{} = attributes.syntax
      assert Regex.match?(attributes.syntax, "A 5")
    end

    test "parses an N/A delimiter as nil" do
      html =
        ~s(<html><body><div class="body"><table summary="kNoDelim">) <>
          ~s(<tr><td>Property</td><td><a name="kNoDelim" href="kNoDelim">kNoDelim</a></td></tr>) <>
          ~s(<tr><td>Delimiter</td><td>N/A</td></tr>) <>
          ~s(</table></div></body></html>)

      assert %{kNoDelim: %{delimiter: nil}} = Property.parse(html)
    end
  end
end
