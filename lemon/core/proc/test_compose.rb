Covers 'facets/proc/compose'

Case Proc do

  Unit :compose do
    a = lambda { |x| x + 4 }
    b = lambda { |y| y / 2 }
    (a.compose(b)).call(4).assert == 6
    (b.compose(a)).call(4).assert == 4
  end

  Unit :* do
    a = lambda { |x| x + 4 }
    b = lambda { |y| y / 2 }
    (a * b).call(4).assert == 6
    (b * a).call(4).assert == 4
  end

end
