Covers 'facets/string/pathize'

Case String do

  Unit :pathize => "module name" do
    a = "Foo::Base"
    x = "foo/base"
    a.pathize.assert == x
  end

  Unit :pathize => "path name" do
    a = "foo/base"
    x = "foo/base"
    a.pathize.assert == x
  end

  Unit :pathize => "name space" do
    a = "foo__base"
    x = "foo/base"
    a.pathize.assert == x
  end

end

