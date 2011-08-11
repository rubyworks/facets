covers 'facets/string/tabto'

test_case String do

  # TODO: Need to expand tabto tests
  method :tabto do

    test do
      a = "xyz".tabto(4)
      a[0..3].assert ==  '    '
    end

  end

end

