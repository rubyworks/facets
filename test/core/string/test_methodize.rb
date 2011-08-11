covers 'facets/string/methodize'

test_case String do

  method :methodize do

    test "module name" do
      a = "FooBase"
      r = "foo_base"
      a.methodize.assert == r
    end

    test "path name"  do
      a = "foo/base"
      r = "foo__base"
      a.methodize.assert == r
    end

    test "name space" do
      a = "Foo::Base"
      r = "foo__base"
      a.methodize.assert == r
    end

  end

end

