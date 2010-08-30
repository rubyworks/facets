covers 'facets/string/tab'

testcase String do

  # TODO: Need to expand on #tab tests.
  unit :tab do
    a = "xyz".tab(4)
    a[0..3].assert == '    '
  end

end

