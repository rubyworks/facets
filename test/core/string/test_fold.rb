covers 'facets/string/fold'

test_case String do

  method :fold do

    test do
      s = "This is\na test.\n\nIt clumps\nlines of text."
      o = "This is a test.\n\nIt clumps lines of text."
      s.fold.assert == o
    end

    test "leave spaces" do
      s = "This is\na test.\n\n  This is pre.\n  Leave alone.\n\nIt clumps\nlines of text."
      o = "This is a test.\n\n  This is pre.\n  Leave alone.\n\nIt clumps lines of text."
      s.fold(true).assert == o
    end

  end

end
