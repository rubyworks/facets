require 'facets/string/modulize'

Case String do

  Unit :modulize => "snakecase" do
    a = "foo_bar"
    r = "FooBar"
    a.modulize.assert == r
  end

  Unit :modulize => "path name" do
    a = "foo/bar"
    r = "Foo::Bar"
    a.modulize.assert == r
  end

  Unit :modulize => "on methodized string" do
    a = "foo__bar"
    r = "Foo::Bar"
    a.modulize.assert == r
  end

end

