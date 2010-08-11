Covers 'facets/array/before'

TestCase Array do

  instance do
    ['a', 'b', 'c']
  end

  unit :before do |sequence|
    sequence.before('a').assert == 'c'
    sequence.before('b').assert == 'a'
    sequence.before('c').assert == 'b'
    sequence.before('d').assert == nil
  end

end

