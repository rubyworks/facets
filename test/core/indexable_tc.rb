covers 'facets/indexable'
covers 'facets/array/indexable'

test_case Indexable do

  method :head do
    test do
      [1,2,3].head.assert == [1]
    end
  end

  method :tail do
    test do
      [1,2,3].tail.assert == [2,3]
    end
  end

  method :foot do
    test do
      [1,2,3].foot.assert == [3]
    end
  end

  method :body do
    test do
      [1,2,3].body.assert == [1,2]
    end
  end

  method :mid do
    test do
      %w{W o r l d}.mid.assert == 'r'
      %w{W o r l d}.mid(1).assert == 'l'
      %w{W o r l d}.mid(-1).assert == 'o'
    end
  end

  method :mid do
    test do
      a = [1,2,3,4,5]
      b = [1,2,3,4,5,6]
      a.mid.assert == 3
      b.mid.assert == 4
      a.mid(1).assert == 4
      b.mid(1).assert == 5
      b.mid(2).assert == 6
      b.mid(-1).assert == 3
    end
  end

  method :middle do
    test do
      [1,2,3,4,5].middle.assert == [3]
      [1,2,3,4,5,6].middle.assert == [3,4]
    end
  end

  method :middle do
    test do
      %w{W o r l d}.middle.assert == ['r']
      %w{W o r l d y}.middle.assert == ['r', 'l']
    end
  end

  method :middle do
    test do
      [1,2,3,4,5].middle(1).assert == [2,3,4]
      [1,2,3,4,5,6].middle(1).assert == [2,3,4,5]
    end
  end

  method :from do
    test do
      %w{W o r l d}.from(3).assert == %w{l d}
    end
  end

  method :thru  do
    test "single parameter" do
      a = [1,2,3,4,5]
      r = a.thru(3)
      r.assert == [1,2,3,4]
    end

    test "dual parameter" do
      a = [1,2,3,4,5]
      r = a.thru(3,4)
      r.assert == [4,5]
    end

    test do
      [0,1,2,3,4,5].thru(2,4).assert == [2,3,4]
      [0,1,2,3,4,5].thru(0,1).assert == [0,1]
    end
  end

  # to be deprecated
  method :index_of do
    test do
      [1,2,3,4].index_of{ |e| e == 3 }.assert == 2
      [1,2,3,4].index_of{ |e| e > 3 }.assert == 3
    end
  end

  method :first= do
    test do
      a = [1,2,3]
      a.first = 9
      a.assert == [9,2,3]
    end
  end

  method :last= do
    test do
      a = [1,2,3]
      a.last = 9
      a.assert == [1,2,9]
    end
  end

  method :ends do
    test do
      [1,2,3,4,5].ends.assert == 4
    end
  end

  method :pos do
    test do
      [1,2,3,4,5].pos(1).assert == 0
      [1,2,3,4,5].pos(-1).assert == 4
    end
  end

  method :range do
    test do
      ['a','b','c','d'].range.assert == (0..3)
      ['a','b','c','d'].range('b','d').assert == (1..3)
    end
  end

  method :range do
    test do
      a = [1,2,3,4,5]
      b = [1,2,3,4,5,6]
      a.range.assert == (0..4)
      b.range.assert == (0..5)
      a.range(2,4).assert == (1..3)
      b.range(2,3).assert == (1..2)
      b.range(4,2).assert == (3..1)
    end
  end

  # We can't use an Array to test the following methods b/c
  # Array handles them specially, either for efficency reasons,
  # or becuase the have been added to Ruby as of 1.8.7+.

  setup "special Indexable object" do
    @c = Class.new do
      include Indexable
      def initialize(*a); @a = a; end
      def slice(*a)  ; @a.slice(*a)  ; end
      def splice(*a) ; @a.splice(*a) ; end
      def size       ; @a.size       ; end
      def to_a       ; @a            ; end
    end
  end

  method :first do
    test do
      a = @c.new(1,2,3,4,5)
      r = a.first(3)
      r.assert == [1,2,3]
    end
  end

  method :last do
    test do
      a = @c.new(1,2,3,4,5)
      r = a.last(3)
      r.assert == [3,4,5]
    end
  end

  method :first! do
    test do
      a = @c.new(1,2,3,4,5)
      e = a.first!
      e.assert == 1
      a.to_a.assert == [2,3,4,5]
    end
  end

  method :last! do
    test do
      a = @c.new(1,2,3,4,5)
      e = a.last!
      e.assert == 5
      a.to_a.assert == [1,2,3,4]
    end
  end

  method :index do
    test do
      @c.new(1,2,3,4).index{ |e| e == 3 }.assert == 2
      @c.new(1,2,3,4).index{ |e| e > 3 }.assert == 3
    end
  end

  #method :[] do
  #  test do
  #    a = ['a','b','c','d','e','f']
  #    assert_equal( ['b','f'], a[[1,-1]] )
  #  end
  #end

  #method :[]= do
  #  test do
  #    a = ['a','o','z']
  #    a[[0,2]] = ['A','Z']
  #    assert_equal( ['A','o','Z'], a )
  #    a[[0,-1]] = ['W','Y']
  #    assert_equal( ['W','o','Y'], a )
  #  end
  #end

end
