covers 'facets/module/cattr'

test_case Class do

  method :cattr do
    test do
      c = Class.new do
        @@xc = 10
        cattr :xc
      end
      t = c.new
      t.xc.assert == 10
      c.xc.assert == 10
    end
  end

  method :cattr_reader do
    test do
      c = Class.new do
        @@xr = 10
        cattr_reader :xr
      end
      t = c.new
      t.xr.assert == 10
      c.xr.assert == 10
    end
  end

  method :cattr_writer do
    test do
      c = Class.new do
        #@@xw = nil
        cattr_writer :xw
        def xw?; @@xw; end
      end
      t = c.new
      t.xw = 5
      t.xw?.assert == 5
    end
  end

  method :cattr_accessor do
    test do
      c = Class.new do
        cattr_accessor :xa
      end
      t = c.new
      c.xa = 50
      c.xa.assert == 50
      t = c.new
      t.xa.assert == 50
    end
  end

end
