covers 'facets/string/margin'

test_case String do

  # TODO: Need to expand margin tests
  method :margin do

    test do
      a = "xyz".margin(4)
      a[0..3].assert ==  '    '
    end

  end

end

