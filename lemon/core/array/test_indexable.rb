Covers 'facets/array/indexable'

TestCase Array do

  Unit :head do
    a = [1,2,3,4,5]
    a.head.assert == [1]
  end

  Unit :tail do
    a = [1,2,3,4,5]
    a.tail.assert == [2,3,4,5]
  end

  Unit :foot do
    a = [1,2,3,4,5]
    a.foot.assert == [5]
  end

  Unit :body do
    a = [1,2,3,4,5]
    a.body.assert == [1,2,3,4]
  end

  Unit :mid do
    a = [1,2,3,4,5]
    b = [1,2,3,4,5,6]
    a.mid.assert == 3
    b.mid.assert == 4
    a.mid(1).assert == 4
    b.mid(1).assert == 5
    b.mid(2).assert == 6
    b.mid(-1).assert == 3
  end

  Unit :middle do
    a = [1,2,3,4,5]
    b = [1,2,3,4,5,6]
    a.middle == 3
    b.middle == [3,4]
  end

  #Unit :op_fetch do
  #  a = ['a','b','c','d','e','f']
  #  assert_equal( ['b','f'], a[[1,-1]] )
  #end
  #
  #Unit :op_store do
  #  a = ['a','o','z']
  #  a[[0,2]] = ['A','Z']
  #  assert_equal( ['A','o','Z'], a )
  #  a[[0,-1]] = ['W','Y']
  #  assert_equal( ['W','o','Y'], a )
  #end

  Unit :thru do
    [0,1,2,3,4,5].thru(2,4).assert == [2,3,4]
    [0,1,2,3,4,5].thru(0,1).assert == [0,1]
  end

  Unit :first= do
    a = [1,2]
    a.first = 0
    a.assert == [0,2]
  end

  Unit :last= do
    a = [1,2]
    a.last = 3
    a.assert == [1,3]
  end

  Unit :ends do
    [1,2,3,4,5].ends.assert == 4
  end

  Unit :pos do
    a = [1,2,3,4,5]
    a.pos(1)  == 0
    a.pos(-1) == 4
  end

  Unit :range do
    a = [1,2,3,4,5]
    b = [1,2,3,4,5,6]
    a.range.assert == (0..4)
    b.range.assert == (0..5)
    a.range(2,4).assert == (1..3)
    b.range(2,3).assert == (1..2)
    b.range(4,2).assert == (3..1)
  end

  Unit :first! do
    a = [1,2,3]
    a.first! == 1
    a.assert == [2,3]
  end

  Unit :last! do
    a = [1,2,3]
    a.last!.assert == 3
    a.assert == [1,2]
  end

end

