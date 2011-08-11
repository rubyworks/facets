covers 'facets/string/modulize'

test_case String do

  method :modulize do

    test "snakecase" do
      a = "foo_bar"
      r = "FooBar"
      a.modulize.assert == r
    end

    test "path name" do
      a = "foo/bar"
      r = "Foo::Bar"
      a.modulize.assert == r
    end

    test "on methodized string" do
      a = "foo__bar"
      r = "Foo::Bar"
      a.modulize.assert == r
    end

  end

end

