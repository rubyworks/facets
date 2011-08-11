covers 'facets/comparable/clip'

test_case Comparable do

  method :clip do

    test 'single argument' do
      3.clip(4).assert == 4
      4.clip(4).assert == 4
      5.clip(4).assert == 5
    end

    test 'two arguments' do
      4.clip(3,5).assert == 4
      3.clip(3,5).assert == 3
      5.clip(3,5).assert == 5
      2.clip(3,5).assert == 3
      6.clip(3,5).assert == 5
    end

    test 'on strings' do
      'd'.clip('c','e').assert == 'd'
      'c'.clip('c','e').assert == 'c'
      'e'.clip('c','e').assert == 'e'
      'b'.clip('c','e').assert == 'c'
      'f'.clip('c','e').assert == 'e'
    end

  end

end
