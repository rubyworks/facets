Covers 'facets/kernel/method'

Case Kernel do

  Unit :method! do
    c = Class.new do
      def foo ; 'foo' ; end
    end

    ic = c.new
    ic.method(:foo).__id__.refute == ic.method(:foo).__id__
    ic.method!(:foo).__id__.assert == ic.method!(:foo).__id__
  end

end

