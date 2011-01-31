covers 'facets/string/index_all'

testcase String do

  unit :index_all do
    "axxxaxxxa".index_all('a').assert == [0,4,8]
  end

end

