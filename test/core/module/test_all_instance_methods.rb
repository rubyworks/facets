covers 'facets/module/all_instance_methods'

test_case Module do

  method :all_instance_methods do

    test do
      c = Class.new do
        def x; "x"; end
        private
        def y; "y"; end
        protected
        def z; "z"; end
      end

      list = c.all_instance_methods(false)

      list.map!{ |m| m.to_sym } # b/c of diff in 1.8 vs 1.9

      list.assert.include?(:x)
      list.assert.include?(:y)
      list.assert.include?(:z)
    end

  end

end
