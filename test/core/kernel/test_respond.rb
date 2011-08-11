covers 'facets/kernel/respond'

test_case Kernel do

  method :respond do

    test do
      c = Class.new do
        def f; "f"; end
      end
    
      x = c.new
      x.respond(:f).assert == "f"
      x.respond(:g).assert == nil

      x.respond.f.assert == "f"
      x.respond.g.assert == nil
    end

  end

  #
  #method :respond_with_value do
  #  test do
  #    c = Class.new do
  #      def f; "f"; end
  #    end
  #
  #    x = c.new
  #    x.respond_with_value(:f).assert == "f"
  #    x.respond_with_value(:g).assert == nil
  #
  #    x.respond_with_value.f.assert == "f"
  #    x.respond_with_value.g.assert == nil
  #  end
  #end

end
