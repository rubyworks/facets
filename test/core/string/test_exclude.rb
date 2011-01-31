covers 'facets/string/exclude'

tests String do

  unit :exclude? do
    "aaaa".assert.exclude?('bb')
    "aaab".assert.exclude?('bb')
    "aaba".assert.exclude?('bb')
    "baaa".assert.exclude?('bb')
  end

  unit :exclude? do
    "abba".refute.exclude?('bb')
    "aabb".refute.exclude?('bb')
    "bbaa".refute.exclude?('bb')
  end

end

