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


    test "leaves empty lines alone, as ActiveSupport does" do
      "a\n\nb".indent(2).assert == "  a\n\n  b"
    end

    test "indents empty lines when asked" do
      "a\n\nb".indent(2, ' ', true).assert == "  a\n  \n  b"
    end

    test "uses the string's own indentation character" do
      "\ta".indent(1).assert == "\t\ta"
      "a\n b".indent(1).assert == " a\n  b"
    end

    test "removes a multi-character indent string whole" do
      "----xyz".indent(-1, '--').assert == '--xyz'
      "-xyz".indent(-1, '--').assert == '-xyz'
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


    test "takes the same arguments as #indent" do
      s = "a\n\nb"
      s.indent!(1, '-', true)
      s.assert == "-a\n-\n-b"
    end

  end

  #method :unindent do
  #  test "is an alias for negative indent" do
  #    '  xyz'.unindent(2).assert == 'xyz'
  #  end
  #end

end
