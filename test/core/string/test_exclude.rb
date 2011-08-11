covers 'facets/string/exclude'

test_case String do

  method :exclude? do

    test do
      "aaaa".assert.exclude?('bb')
      "aaab".assert.exclude?('bb')
      "aaba".assert.exclude?('bb')
      "baaa".assert.exclude?('bb')
    end

    test do
      "abba".refute.exclude?('bb')
      "aabb".refute.exclude?('bb')
      "bbaa".refute.exclude?('bb')
    end

  end

end

