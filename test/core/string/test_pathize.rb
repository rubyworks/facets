covers 'facets/string/pathize'

testcase String do

  unit :pathize => "module name" do
    a = "Foo::Base"
    x = "foo/base"
    a.pathize.assert == x
  end

  unit :pathize => "path name" do
    a = "foo/base"
    x = "foo/base"
    a.pathize.assert == x
  end

  unit :pathize => "name space" do
    a = "foo__base"
    x = "foo/base"
    a.pathize.assert == x
  end

end

