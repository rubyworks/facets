require 'facets/string/methodize'

Case String do

  Unit :methodize => "module name" do
    a = "FooBase"
    r = "foo_base"
    a.methodize.assert == r
  end

  Unit :methodize => "path name"  do
    a = "foo/base"
    r = "foo__base"
    a.methodize.assert == r
  end

  Unit :methodize => "name space"
    a = "Foo::Base"
    r = "foo__base"
    a.methodize.assert == r
  end

end

