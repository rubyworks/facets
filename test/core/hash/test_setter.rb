covers 'facets/hash/setter'

test_case Hash do

  method :setter do

    test do
      c = Class.new do
        attr_accessor :a
      end

      h = {:a => 1}
      o = c.new

      h.setter.call(o)

      o.a.assert == 1
    end

  end

end
