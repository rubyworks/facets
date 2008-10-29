unless (RUBY_VERSION[0,3] == '1.9')

  class Array

    # Provides the cross-product of two or more Enumerables.
    # This is the class-level method. The instance method
    # calls on this.
    #
    #   Enumerable.cartesian_product([1,2], [4], ["apple", "banana"])
    #   #=> [[1, 4, "apple"], [1, 4, "banana"], [2, 4, "apple"], [2, 4, "banana"]]
    #
    #   Enumerable.cartesian_product([1,2], [3,4])
    #   #=> [[1, 3], [1, 4], [2, 3], [2, 4]]
    #
    #   a = []
    #   [1,2].cart([4,5]){|elem| a << elem }
    #   a  #=> [[1, 4],[1, 5],[2, 4],[2, 5]]
    #
    #  CREDIT: Thomas Hafner

    def product(*enums, &block)
      enums.unshift self
      result = [[]]
      while [] != enums
        t, result = result, []
        b, *enums = enums
        t.each do |a|
          b.each do |n|
            result << a + [n]
          end
        end
      end
      if block_given?
        result.each{ |e| block.call(e) }
      else
        result
      end
    end

  end

end


class Array

  # Operator alias for cross-product.
  #
  #   a = [1,2] ** [4,5]
  #   a  #=> [[1, 4],[1, 5],[2, 4],[2, 5]]
  #
  #  CREDIT: Trans

  alias_method :**, :product

end

