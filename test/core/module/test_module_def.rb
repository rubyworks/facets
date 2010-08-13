covers 'facets/module/module_def'

tests Module do

  unit :module_def do
    m = Module.new
    m.module_def(:x){"x"}
    c = Class.new{ include m }
    c.new.x.assert == "x"
  end

  unit :module_def do
    c = Class.new
    c.module_def(:x){"x"}
    c.new.x.assert == "x"
  end

end
