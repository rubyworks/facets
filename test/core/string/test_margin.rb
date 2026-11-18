covers 'facets/string/margin'

test_case String do

  method :margin do

    test do
      a = "xyz".margin(4)
      a[0..3].assert ==  '    '
    end

    test "moves the least indented line to the margin" do
      "  abc\n    xyz".margin(0).assert == "abc\n  xyz"
      "abc\n  xyz".margin(2).assert == "  abc\n    xyz"
      "    abc\n  xyz".margin(1).assert == "   abc\n xyz"
    end

    test "ignores blank lines when finding the least indented line" do
      "    abc\n\n    xyz".margin(2).assert == "  abc\n\n  xyz"
    end

    test "counts a tab as two spaces, or as the :tab option says" do
      "\tabc".margin(0).assert == "abc"
      "\tabc\n  xyz".margin(1).assert == " abc\n xyz"
      "\tabc\n  xyz".margin(0, :tab => 4).assert == "  abc\nxyz"
    end

    test "with :lead, moves the first line that isn't blank to the margin" do
      "    abc\n      xyz".margin(2, :lead => true).assert == "  abc\n    xyz"
      "    abc\n  xyz".margin(2, :lead => true).assert == "  abc\nxyz"
    end

    test "with :flush, gives every line the same margin" do
      "abc\n    xyz".margin(2, :flush => true).assert == "  abc\n  xyz"
      "      abc\n  xyz".margin(0, :flush => true).assert == "abc\nxyz"
    end

    test "with :flush, treats leading tabs as indentation" do
      "\tabc\n \t xyz".margin(2, :flush => true).assert == "  abc\n  xyz"
    end

    test "with :flush, leaves blank lines and the rest of each line alone" do
      "abc  def\n\n   \n  xyz\n".margin(2, :flush => true).assert == "  abc  def\n\n   \n  xyz\n"
    end

    test "does not change the receiver" do
      s = "abc\n  xyz"
      s.margin(2, :flush => true)
      s.assert == "abc\n  xyz"
    end

    test "must be given a margin" do
      ArgumentError.assert.raised? { "abc".margin }
    end

  end

end
