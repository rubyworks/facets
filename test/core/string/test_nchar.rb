covers 'facets/string/nchar'

test_case String do

  method :nchar do

    test do
      "abcxyz".nchar(3).assert == "abc"
      "abcxyz".nchar(-3).assert == "xyz"
      "abcxyz".nchar(3, 'HI').assert == "HIxyz"
      "abcxyz".nchar(-3, 'HI').assert == "abcHI"
    end

  end

end

