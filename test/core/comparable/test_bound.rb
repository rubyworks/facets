covers 'facets/comparable/bound'

test_case Comparable do

  method :bound do

    test 'single argument' do
      3.bound(4).assert == 4
      4.bound(4).assert == 4
      5.bound(4).assert == 5
    end

    test 'two arguments' do
      4.bound(3,5).assert == 4
      3.bound(3,5).assert == 3
      5.bound(3,5).assert == 5
      2.bound(3,5).assert == 3
      6.bound(3,5).assert == 5
    end

    test 'on strings' do
      'd'.bound('c','e').assert == 'd'
      'c'.bound('c','e').assert == 'c'
      'e'.bound('c','e').assert == 'e'
      'b'.bound('c','e').assert == 'c'
      'f'.bound('c','e').assert == 'e'
    end

  end

end

