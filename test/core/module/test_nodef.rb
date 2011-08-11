covers 'facets/module/nodef'

test_case Module do

  method :nodef do

    test do
      c = Class.new do
        def the_undefined_method ; 'not here' ; end
        nodef :the_undefined_method
      end

      c.new.refute.respond_to?(:the_undefined_method)
    end

  end

end

