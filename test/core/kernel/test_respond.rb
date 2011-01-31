covers 'facets/kernel/respond'

tests Kernel do

  unit :respond do
    c = Class.new do
      def f; "f"; end
    end
  
    x = c.new
    x.respond(:f).assert == "f"
    x.respond(:g).assert == nil

    x.respond.f.assert == "f"
    x.respond.g.assert == nil
  end

  #
  #unit :respond_with_value do
  #  c = Class.new do
  #    def f; "f"; end
  #  end
  #
  #  x = c.new
  #  x.respond_with_value(:f).assert == "f"
  #  x.respond_with_value(:g).assert == nil
  #
  #  x.respond_with_value.f.assert == "f"
  #  x.respond_with_value.g.assert == nil
  #end

end
