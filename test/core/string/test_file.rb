covers 'facets/string/file'

testcase String do

  unit :file do
    "home/trans".file.dirname.assert == "home"
    "home/trans".file.basename.assert == "trans"
  end

end

