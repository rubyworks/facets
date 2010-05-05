Covers 'facets/string/indent'

Case String do

  Unit :indent => "positive" do
    "xyz".indent(4).assert == '    xyz'
    "  xyz".indent(2).assert == '    xyz'
  end

  Unit :indent => "multiline positive" do
    "abc\nxyz".indent(2).assert ==  "  abc\n  xyz"
  end

  Unit :indent => "zero" do
    'xyz'.indent(0).assert == 'xyz'
  end

  Unit :indent => "negative" do
    '    xyz'.indent(-2).assert == '  xyz'
    '  xyz'.  indent(-2).assert == 'xyz'
  end

  Unit :indent => "multiline negative" do
    "    abc\n    xyz".indent(-2).assert == "  abc\n  xyz"
  end

  Unit :outdent => "is an alias for negative indent" do
    '  xyz'.outdent(2).assert == 'xyz'
  end

  Unit :indent => "negative more than is possible" do
    '  xyz'.indent(-3).assert == 'xyz'
  end

  Unit :indent => "non-space positive" do
    "xyz".indent(4, '-').assert == '----xyz'
  end

  Unit :indent => "non-space zero" do
    'xyz'.indent(0, '-').assert == 'xyz'
  end

  Unit :indent => "non-space negative non-matching character" do
    '    xyz'.indent(-2, '-').assert == '    xyz'
    '  xyz'.  indent(-2, '-').assert == '  xyz'
  end

  Unit :indent => "non-space negative" do
    '----xyz'.indent(-2, '-').assert == '--xyz'
    '--xyz'.indent(-2, '-').assert == 'xyz'
  end

  Concern "Special regular expresion characters are escaped."

  Unit :indent => "ensure '.' is treated literally and not as wildcard" do
    '  xyz'.indent(-2, '.').assert == '  xyz'
    '..xyz'.indent(-2, '.').assert == 'xyz'
  end

  Unit :indent => "ensure '*' is treated literally and not as wildcard" do
    '  xyz'.indent(-2, '*').assert == '  xyz'
    '**xyz'.indent(-2, '*').assert == 'xyz'
  end

  Unit :indent => "ensure '^' is treated literally and not as line start" do
    '  xyz'.indent(-2, '^').assert == '  xyz'
    '^^xyz'.indent(-2, '^').assert == 'xyz'
  end

end

