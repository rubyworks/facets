covers 'facets/enumerator'

tests Enumerator::Yielder do

  meta :new do
    y = Enumerator::Yielder.new(proc{ |x| x + 1 })
  end

  unit :yield do
    y = Enumerator::Yielder.new(proc{ |x| x + 1 })
    y.yield(1).assert == 2
  end

  unit :<< do
    y = Enumerator::Yielder.new(proc{ |x| x + 1 })
    (y << 1).assert == 2
  end

  unit :<< do
    y = Enumerator::Yielder.new(proc{ |x,y| x + y })
    (y.<<(1,2)).assert == 3
  end

end
