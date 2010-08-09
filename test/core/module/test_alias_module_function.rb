Covers 'facets/module/alias_module_function'

Case Module do

  Unit :alias_module_function do
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

