covers 'facets/kernel/qua_class'

test_case Kernel do

  method :qua_class do

    test do
      o = Object.new
      s = (class << o; self; end)
      o.qua_class.assert == s
    end

  end

  method :quaclass do

    test do
      o = Object.new
      s = (class << o; self; end)
      o.quaclass.assert == s
    end

  end

end
