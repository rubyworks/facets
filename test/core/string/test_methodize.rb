covers 'facets/string/methodize'

testcase String do

  unit :methodize => "module name" do
    a = "FooBase"
    r = "foo_base"
    a.methodize.assert == r
  end

  unit :methodize => "path name"  do
    a = "foo/base"
    r = "foo__base"
    a.methodize.assert == r
  end

  unit :methodize => "name space" do
    a = "Foo::Base"
    r = "foo__base"
    a.methodize.assert == r
  end

end

