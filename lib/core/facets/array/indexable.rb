require 'facets/indexable'
require 'facets/array/splice'

class Array

  include Indexable

  # Alias for shift, which removes and returns
  # the first element in an array.
  #
  #   a = ["a","y","z"]
  #   a.first!      #=> "a"
  #   p a           #=> ["y","z"]
  #
  #  CREDIT: Trans

  alias_method :first!, :shift

  # Alias for pop, which removes and returns
  # the last element in an array.
  #
  #   a = [1,2]
  #   a.last! 3
  #   p a           #=> [1,2,3]
  #
  #  CREDIT: Trans

  alias_method :last!, :pop

  #
  #

  #alias_method :/, :[]

=begin
  # TODO Probably not best to overide store and fetch operators. Rename?

  # Modifies #[] to also accept an array of indexes.
  #
  #   a = ['a','b','c','d','e','f']
  #
  #   a[[1]]      #=> ['b']
  #   a[[1,1]]    #=> ['b','b']
  #   a[[1,-1]]   #=> ['b','f']
  #   a[[0,2,4]]  #=> ['a','c','e']
  #
  def [](*args)
    return values_at(*args.at(0)) if Array === args.at(0)
    return slice(*args)
  end

  # Modifies #[]= to accept an array of indexes for assignment.
  #
  #   a = ['a','b','c','d']
  #
  #   a[[1,-1]] = ['m','n']    #=> ['m','n']
  #   a                        #=> ['a','m','c','n']
  #
  def []=(*args)
    if Array === args.at(0)
      idx,vals = args.at(0),args.at(1)
      idx.each_with_index{ |a,i| store(a,vals.at(i)) }
      return values_at( *idx )
    else
      return store(*args)
    end
  end

end
=end

end

