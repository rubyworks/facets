class Array

  if RUBY_VERSION < '1.9'

    # Provides the cartesian product of two or more arrays.
    #
    #   a = []
    #   [1,2].product([4,5]){|elem| a << elem }
    #   a  #=> [[1, 4],[1, 5],[2, 4],[2, 5]]
    #
    # CREDIT: Thomas Hafner

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

  else

    alias_method :_product, :product

    def product(*enums, &block)
      result = _product(*enums)
      return (block_given?) ? result.each{ |e| block.call(e) } : result
    end

  end

  # Operator alias for cross-product.
  #
  #   a = [1,2] ** [4,5]
  #   a  #=> [[1, 4],[1, 5],[2, 4],[2, 5]]
  #
  # CREDIT: Trans

  alias_method :**, :product

end

