require 'facets/array/recursive_each'
require 'facets/hash/recursive_each'

module Enumerable

  # Recursively iterate over the Eenumerable's elements.
  # If an element is the same type of object as the
  # object being itereated over, then it too will also
  # be iterated over.
  #
  # NOTE: Classes than inherit Enumberable should override
  # this method to check for proper conversion method
  # (eg. to_ary for Array), if applicable, rather than
  # checking the class type.
  #
  def recursive_each(&block)
    if block_given?
      each do |e|
        case e
        when self.class
          e.recursive(&block)
        else
          block.call(e)
        end
      end
    else
      to_enum(:recursive)
    end
  end

end

