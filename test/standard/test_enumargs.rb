covers 'facets/enumargs'

test_case Enumerable::Arguments do

  setup do
    @PlusArray = Class.new do
      include Enumerable::Argumentable
      def initialize(arr)
        @arr = arr
      end
      def each(n=0)
        @arr.each{ |e| yield(e+n) }
      end
    end
  end

  method :collect do
    test do
      t = @PlusArray.new([1,2,3])
      r = t.collect(4){ |e| e }
      r.assert == [5,6,7]
    end
  end

  #method :each_slice do
  #  test do
  #    t = PlusArray.new([1,2,3,4])
  #    a = []
  #    t.each_slice(2,4){ |e,f| a << [e,f] }
  #    a.assert == [[5,6],[7,8]]
  #  end
  #end

  #method :find do
  #  test do
  #    t = PlusArray.new([1,2,3,4])
  #    f = t.find(2, :ifnone=>lambda{:NOPE}) { |a| a == 10 }
  #    f.assert == :NOPE
  #  end
  #end

  method :grep do
  end

  method :to_a do
    test do
      t = @PlusArray.new([1,2,3])
      t.to_a(4).assert == [5,6,7]
    end
  end

  # TODO: These two methods have issues! Any way to fix?
  skip do
		method :min do
		  test do
		    t = @PlusArray.new([1,2,3])

		    # test is failing.  min has a variable number
		    #  of arguments which makes it's .arity = -1.
		    #  given the way this works for arity -1
		    #  the method always passes the single argument to
		    #  the min method, and passes nothing to the each
		    #  resulting it taking the X smallest values of the
		    #  given and unchanged array
		    t.min(4).assert = 5 # returning [1,2,3]
		  end
		end

    method :max do
      # test is failing.  max has a variable number of arguments which makes it
      #  .arity = -1.  given the way this works for arity -1 the method
      #  always passes the single argument to the max method, and passes nothing
      #  to the each resulting it taking the X largest values of the given and
      #  unchanged array
      test do
        t = @PlusArray.new([1,2,3])
        t.max(4).assert == 7
      end
    end
  end

  method :include? do
    test do
      t = @PlusArray.new([1,2,3])
      t.assert.include?(7,4)
    end
  end

  method :select do
    test do
      t = @PlusArray.new([1,2,3])
      r = t.select(4){ |x| x == 6 }
      r.assert == [6]
    end
  end

  method :reject do
    test do
      t = @PlusArray.new([1,2,3])
      r = t.reject(4){ |x| x == 6 }
      r.assert == [5,7]
    end
  end

end
