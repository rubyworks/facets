covers 'facets/module/preextend'

test_case Module do

  method :preextend do

    test "module method" do
      m = Module.new do
        def q; "qm"; end
      end

      n = Module.new do
        preextend m
        def q; "qn"; end
      end

      x = Class.new do
        include n
      end

      n.q.assert == "qm"
    end

  end

end
