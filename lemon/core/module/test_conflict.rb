Covers 'facets/module/conflict'

Case Module do

  if RUBY_VERSION < '1.9'

    Unit :conflict? do
      x = Class.new do
        def q; "qx"; end
      end

      y = Class.new do
        def q; "qy"; end
      end

      x.conflict?(y).assert == ["q"]
    end

  else

    Unit :conflict? do
      x = Class.new do
        def q; "qx"; end
      end

      y = Class.new do
        def q; "qy"; end
      end

      x.conflict?(y).assert == [:q]
    end

  end
end

