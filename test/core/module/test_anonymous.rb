covers 'facets/module/anonymous'

test_case Module do

  method :anonymous? do

    test do
      m = Module.new
      m.assert.anonymous?
    end

    test do
      Lemon.refute.anonymous?
    end

  end

end
