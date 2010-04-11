require 'facets/array/permutation'
require 'set'

TestCase Array do

  Unit :permutation do
    r = Set.new
    %w[a b c].permutation{ |x| r << x.join('') }
    x = Set.new(['abc','acb','bac','bca','cab','cba'])
    r.assert == x
  end

end

