require 'facets/array/recursive_map'
require 'facets/hash/recursive_map'

module Enumerable

  # Recursively iterate over and map the Eenumerable's
  # elements. If an element is the same type of object
  # as the object being itereated over, then it too will
  # be iterated over.
  #
  # NOTE: Classes than inherit Enumberable should override
  # this method to check for proper conversion method
  # (e.g. #to_ary for Array), rather than checking the
  # class itself.
  #
  def recursive_map(&block)
    if block_given?
      map do |e|
        case e
        when self.class
          e.recursive_map(&block)
        else
          block.call(e)
        end
      end
    else
      to_enum(:recursive_map)
    end
  end

end

