covers 'facets/string/tab'

test_case String do

  # TODO: Need to expand on #tab tests.
  method :tab do

    test do
      a = "xyz".tab(4)
      a[0..3].assert == '    '
    end

  end

end

