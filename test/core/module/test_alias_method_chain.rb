covers 'facets/module/alias_method_chain'

testcase Module do

  unit :alias_method_chain do

    x = Module.new do
      def self.included(base)
        base.module_eval {
          alias_method_chain :foo, :feature
        }
      end
      def foo_with_feature
        foo_without_feature + '!'
      end
    end

    y = Class.new do
      def foo
        "FOO"
      end
      include x
    end

    iy = y.new

    iy.foo.assert == "FOO!"
  end

end

