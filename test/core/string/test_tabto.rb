covers 'facets/string/tabto'

testcase String do

  # TODO: Need to expand tabto tests
  unit :tabto do
    a = "xyz".tabto(4)
    a[0..3].assert ==  '    '
  end

end

