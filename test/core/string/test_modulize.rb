covers 'facets/string/modulize'

testcase String do

  unit :modulize => "snakecase" do
    a = "foo_bar"
    r = "FooBar"
    a.modulize.assert == r
  end

  unit :modulize => "path name" do
    a = "foo/bar"
    r = "Foo::Bar"
    a.modulize.assert == r
  end

  unit :modulize => "on methodized string" do
    a = "foo__bar"
    r = "Foo::Bar"
    a.modulize.assert == r
  end

end

