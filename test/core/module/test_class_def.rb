covers 'facets/module/class_def'

test_case Module do

  method :class_def do

    test do
      m = Module.new
      m.class_def(:x){"x"}
      c = Class.new{ include m }
      c.new.x.assert == "x"
    end

    test do
      c = Class.new
      c.class_def(:x){"x"}
      c.new.x.assert == "x"
    end

  end

end
