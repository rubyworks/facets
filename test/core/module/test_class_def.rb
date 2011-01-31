covers 'facets/module/class_def'

tests Module do

  unit :class_def do
    m = Module.new
    m.class_def(:x){"x"}
    c = Class.new{ include m }
    c.new.x.assert == "x"
  end

  unit :class_def do
    c = Class.new
    c.class_def(:x){"x"}
    c.new.x.assert == "x"
  end

end
