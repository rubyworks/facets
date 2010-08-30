covers 'facets/string/op_sub'

testcase String do

  unit :"-" do
    s = "xxbooxxfoo"
    (s - "xx").assert == "boofoo"
  end

end

