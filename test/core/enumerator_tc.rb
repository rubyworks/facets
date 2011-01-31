covers 'facets/enumerator'

tests Enumerator::Yielder do

  meta :new do
    y = Enumerator::Yielder.new{ |x| x + 1 }
  end

  unit :yield do
    y = Enumerator::Yielder.new{ |x| x + 1 }
    y.yield(1).assert == 2
  end

  unit :<< do
    a = []
    y = Enumerator::Yielder.new{ |x| a << x + 1 }
    y << 1
    a.assert == [2]
  end

  unit :<< do
    a = []
    y = Enumerator::Yielder.new{ |x,y| a << x + y }
    y.<<(1,2)
    a.assert == [3]
  end

end
