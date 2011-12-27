covers 'facets/kernel/object_hexid'

test_case Kernel do

  method :object_hexid do

    omit "too inconsitent across platforms" do

      test do
        o = Object.new
        "#<Object:#{o.object_hexid}>".assert == o.inspect
        #assert(o.inspect.index(o.object_hexid))
      end

    end

  end

end

