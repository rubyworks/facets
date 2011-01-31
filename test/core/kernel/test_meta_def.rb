covers 'facets/kernel/meta_def'

tests Kernel do

  unit :meta_def do
    x = Class.new
    x.meta_def(:x){"x"}
    x.x.assert == "x"
  end

end
