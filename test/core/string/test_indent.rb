covers 'facets/string/indent'

test_case String do

  method :indent do

    test "positive" do
      "xyz".indent(4).assert == '    xyz'
      "  xyz".indent(2).assert == '    xyz'
    end

    test "multiline positive" do
      "abc\nxyz".indent(2).assert ==  "  abc\n  xyz"
    end

    test "zero" do
      'xyz'.indent(0).assert == 'xyz'
    end

    test "negative" do
      '    xyz'.indent(-2).assert == '  xyz'
      '  xyz'.  indent(-2).assert == 'xyz'
    end

    test "multiline negative" do
      "    abc\n    xyz".indent(-2).assert == "  abc\n  xyz"
    end

    test "negative more than is possible" do
      '  xyz'.indent(-3).assert == 'xyz'
    end

    test "non-space positive" do
      "xyz".indent(4, '-').assert == '----xyz'
    end

    test "non-space zero" do
      'xyz'.indent(0, '-').assert == 'xyz'
    end

    test "non-space negative non-matching character" do
      '    xyz'.indent(-2, '-').assert == '    xyz'
      '  xyz'.  indent(-2, '-').assert == '  xyz'
    end

    test "non-space negative" do
      '----xyz'.indent(-2, '-').assert == '--xyz'
      '--xyz'.indent(-2, '-').assert == 'xyz'
    end

    Concern "Special regular expresion characters are escaped."

    test "ensure '.' is treated literally and not as wildcard" do
      '  xyz'.indent(-2, '.').assert == '  xyz'
      '..xyz'.indent(-2, '.').assert == 'xyz'
    end

    test "ensure '*' is treated literally and not as wildcard" do
      '  xyz'.indent(-2, '*').assert == '  xyz'
      '**xyz'.indent(-2, '*').assert == 'xyz'
    end

    test "ensure '^' is treated literally and not as line start" do
      '  xyz'.indent(-2, '^').assert == '  xyz'
      '^^xyz'.indent(-2, '^').assert == 'xyz'
    end

  end

  method :indent! do

    test "in place rendition of #unindent" do
      s = "xyz"
      s.indent!(4)
      s.assert == '    xyz'

      s = "  xyz"
      s.indent!(2)
      s.assert == '    xyz'
    end

  end

  #method :unindent do
  #  test "is an alias for negative indent" do
  #    '  xyz'.unindent(2).assert == 'xyz'
  #  end
  #end

end
