covers 'facets/enumerable/squeeze'

test_case Enumerable do

  method :squeeze do

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

    test do
      e = eC.new(1,2,2,3,3,2,1)
      e.squeeze.assert == [1,2,3,2,1]
    end

    test do
      e = eC.new(1,2,2,3,3,2,1)
      e.sort.squeeze.assert == [1,2,3]
    end

  end

end
