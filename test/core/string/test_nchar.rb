covers 'facets/string/nchar'

testcase String do

  unit :nchar do
    "abcxyz".nchar(3).assert == "abc"
    "abcxyz".nchar(-3).assert == "xyz"
    "abcxyz".nchar(3, 'HI').assert == "HIxyz"
    "abcxyz".nchar(-3, 'HI').assert == "abcHI"
  end

end

