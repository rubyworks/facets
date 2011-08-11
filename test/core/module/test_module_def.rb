covers 'facets/module/module_def'

test_case Module do

  method :module_def do

    test do
      m = Module.new
      m.module_def(:x){"x"}
      c = Class.new{ include m }
      c.new.x.assert == "x"
    end

    test do
      c = Class.new
      c.module_def(:x){"x"}
      c.new.x.assert == "x"
    end

  end

end
