covers 'facets/string/indent'

tests String do

  unit :indent => "positive" do
    "xyz".indent(4).assert == '    xyz'
    "  xyz".indent(2).assert == '    xyz'
  end

  unit :indent => "multiline positive" do
    "abc\nxyz".indent(2).assert ==  "  abc\n  xyz"
  end

  unit :indent => "zero" do
    'xyz'.indent(0).assert == 'xyz'
  end

  unit :indent => "negative" do
    '    xyz'.indent(-2).assert == '  xyz'
    '  xyz'.  indent(-2).assert == 'xyz'
  end

  unit :indent => "multiline negative" do
    "    abc\n    xyz".indent(-2).assert == "  abc\n  xyz"
  end

  unit :indent => "negative more than is possible" do
    '  xyz'.indent(-3).assert == 'xyz'
  end

  unit :indent => "non-space positive" do
    "xyz".indent(4, '-').assert == '----xyz'
  end

  unit :indent => "non-space zero" do
    'xyz'.indent(0, '-').assert == 'xyz'
  end

  unit :indent => "non-space negative non-matching character" do
    '    xyz'.indent(-2, '-').assert == '    xyz'
    '  xyz'.  indent(-2, '-').assert == '  xyz'
  end

  unit :indent => "non-space negative" do
    '----xyz'.indent(-2, '-').assert == '--xyz'
    '--xyz'.indent(-2, '-').assert == 'xyz'
  end

  Concern "Special regular expresion characters are escaped."

  unit :indent => "ensure '.' is treated literally and not as wildcard" do
    '  xyz'.indent(-2, '.').assert == '  xyz'
    '..xyz'.indent(-2, '.').assert == 'xyz'
  end

  unit :indent => "ensure '*' is treated literally and not as wildcard" do
    '  xyz'.indent(-2, '*').assert == '  xyz'
    '**xyz'.indent(-2, '*').assert == 'xyz'
  end

  unit :indent => "ensure '^' is treated literally and not as line start" do
    '  xyz'.indent(-2, '^').assert == '  xyz'
    '^^xyz'.indent(-2, '^').assert == 'xyz'
  end

  unit :indent! => "in place rendition of #unindent" do
    s = "xyz"
    s.indent!(4)
    s.assert == '    xyz'

    s = "  xyz"
    s.indent!(2)
    s.assert == '    xyz'
  end

  #unit :unindent => "is an alias for negative indent" do
  #  '  xyz'.unindent(2).assert == 'xyz'
  #end

end

