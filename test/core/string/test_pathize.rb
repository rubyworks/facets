covers 'facets/string/pathize'

test_case String do

  method :pathize do

    test "module name" do
      a = "Foo::Base"
      x = "foo/base"
      a.pathize.assert == x
    end

    test "path name" do
      a = "foo/base"
      x = "foo/base"
      a.pathize.assert == x
    end

    test "name space" do
      a = "foo__base"
      x = "foo/base"
      a.pathize.assert == x
    end

    test 'transforms initial double colon' do
      '::MyClass'.pathize.assert == '/my_class'
    end

  end

end
