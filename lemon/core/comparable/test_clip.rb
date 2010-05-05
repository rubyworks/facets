Covers 'facets/comparable/clip'

TestCase Comparable do

  Unit :clip => 'single argument' do
    3.clip(4).assert == 4
    4.clip(4).assert == 4
    5.clip(4).assert == 5
  end

  Unit :clip => 'two arguments' do
    4.clip(3,5).assert == 4
    3.clip(3,5).assert == 3
    5.clip(3,5).assert == 5
    2.clip(3,5).assert == 3
    6.clip(3,5).assert == 5
  end

  Unit :clip => 'on strings' do
    'd'.clip('c','e').assert == 'd'
    'c'.clip('c','e').assert == 'c'
    'e'.clip('c','e').assert == 'e'
    'b'.clip('c','e').assert == 'c'
    'f'.clip('c','e').assert == 'e'
  end

end
