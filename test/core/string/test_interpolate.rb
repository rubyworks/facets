covers 'facets/string/interpolate'

testcase String do

  metaunit :interpolate do
    a = 1
    String.interpolate{ 'this is #{a}' }.assert == 'this is 1'
  end

end


