covers 'facets/module/alias_module_function'

testcase Module do

  unit :alias_module_function do
    m = Module.new do
      def x ; 33 ; end

      module_function :x

      alias_module_function :y, :x
    end

    m.y.assert == 33

    # use send b/c private?
    #@m.send(:y).assert == 33
  end

end

