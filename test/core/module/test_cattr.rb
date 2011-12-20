covers 'facets/module/cattr'

test_case Class do

  setup do
    @c = Class.new do
      cattr :xc
      cattr_reader :xr
      cattr_writer :xw
      cattr_accessor :xa
      def initialize
        @@xc = 10
        @@xr = 10
        @@xw = nil
      end
      def xw?; @@xw; end
    end
  end

  method :cattr do
    test do
      t = @c.new
      t.xc.assert  == 10
      @c.xc.assert == 10
    end
  end

  method :cattr_reader do
    test do
      t = @c.new
      t.xr.assert  == 10
      @c.xr.assert == 10
    end
  end

  method :cattr_writer do
    test do
      t = @c.new
      t.xw = 5
      t.xw?.assert == 5
    end
  end

  method :cattr_accessor do
    test do
      @c.xa = 50
      @c.xa.assert == 50
      t = @c.new
      t.xa.assert == 50
    end
  end

end
