covers 'facets/array/after'

testcase Array do

  setup do
    ['a', 'b', 'c']
  end

  unit :after do |sequence|
    sequence.after('a').assert == 'b'
    sequence.after('b').assert == 'c'
    sequence.after('c').assert == 'a'
    sequence.after('d').assert == nil
  end

end

