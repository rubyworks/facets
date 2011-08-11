covers 'facets/kernel/meta_def'

test_case Kernel do

  method  :meta_def do

    test do
      x = Class.new
      x.meta_def(:x){"x"}
      x.x.assert == "x"
    end

  end

end
