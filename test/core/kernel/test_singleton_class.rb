covers 'facets/kernel/singleton_class'

test_case Kernel do

  method :singleton_class do

    test do
      x = Class.new
      m = (class << x; self; end)
      x.singleton_class.assert == m
    end

  end

end
