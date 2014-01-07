covers 'facets/enumerable/occur'

test_case Enumerable do

  method :occur do

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
      e = eC.new(:a,:b,:a)
      e.occur(1).assert == [:b]
    end

    test do
      e = eC.new(:a,:b,:a)
      e.occur(2).assert == [:a]
    end

    test do
      e = eC.new(:a,:b,:a)
      e.occur(1..1).assert == [:b]
    end

    test do
      e = eC.new(:a,:b,:a)
      e.occur{ |n| n % 2 == 0 }.assert == [:a]
    end

  end

end
