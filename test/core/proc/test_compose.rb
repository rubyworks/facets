covers 'facets/proc/compose'

test_case Proc do

  method :compose do

    test do
      a = lambda { |x| x + 4 }
      b = lambda { |y| y / 2 }
      (a.compose(b)).call(4).assert == 6
      (b.compose(a)).call(4).assert == 4
    end

  end

  method :* do

    test do
      a = lambda { |x| x + 4 }
      b = lambda { |y| y / 2 }
      (a * b).call(4).assert == 6
      (b * a).call(4).assert == 4
    end

  end

end
