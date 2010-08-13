covers 'facets/kernel/meta_def'

tests Kernel do

  unit :meta_def do
    x = Class.new
    x.meta_def(:x){"x"}
    x.x.assert == "x"
  end

  unit :metadef do
    x = Class.new
    x.metadef(:x){"x"}
    x.x.assert == "x"
  end

end
