require 'facets/object/or'

test_case Object do
  method :or do
    test 'returns self or other' do
      nil.or('something').assert == 'something'
      nil.or(nil).assert == nil
      'something'.or('nothing').assert == 'something'
    end
  end
end



