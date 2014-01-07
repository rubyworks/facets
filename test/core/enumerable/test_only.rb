covers 'facets/enumerable/only'

test_case Enumerable do

  # make an Enumerable class to test
  eC = Class.new do
    include Enumerable
    def initialize(*a)
      @a = a
    end
    def each(&b)
      @a.each(&b)
    end
  end

  method :only? do

    test do
      e = eC.new(false)
      assert e.only?
    end

    test do
      e = eC.new(1)
      assert e.only?
    end

    test do
      e = eC.new(false, false)
      refute e.only?
    end

    test do
      e = eC.new()
      refute e.only?
    end  

  end

end
