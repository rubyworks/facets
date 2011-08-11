covers 'facets/kernel/instance_class'

test_case Kernel do

  method :instance_class do

    test do
      o = Object.new
      o.instance_class.assert == (class << o; self; end)
    end

  end

end

