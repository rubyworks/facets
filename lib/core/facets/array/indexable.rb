require 'facets/indexable'
require 'facets/array/splice'

class Array

  include Indexable

  # Alias for shift, which removes and returns
  # the first element in an array.
  #
  #   a = ["a","y","z"]
  #   a.first!      #=> "a"
  #   a             #=> ["y","z"]
  #
  # CREDIT: Trans

  alias_method :first!, :shift

  # Alias for pop, which removes and returns
  # the last element in an array.
  #
  #   a = [1,2,3]
  #   a.last!       #=> 3
  #   a             #=> [1,2]
  #
  # CREDIT: Trans

  alias_method :last!, :pop

end

