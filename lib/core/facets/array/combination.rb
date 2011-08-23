class Array

  unless method_defined?(:combination) # 1.8.7+

    require 'facets/enumerator'

    # Yields the block to each unique combination of _n_ elements.
    #
    #   a = %w|a b c d|
    #   a.combination(3)
    #
    # produces
    #
    #   [["a", "b", "c"],
    #    ["a", "b", "d"],
    #    ["a", "c", "d"],
    #    ["b", "c", "d"]]
    #
    # CREDIT: Florian Gross

    def combination(k=2)
      if block_given?
        s = to_a
        n = s.size
        return unless (1..n) === k
        idx = (0...k).to_a
        loop do
          yield s.values_at(*idx)
          i = k - 1
          i -= 1 while idx[i] == n - k + i
          break if i < 0
          idx[i] += 1
          (i + 1 ... k).each {|j| idx[j] = idx[i] + j - i}
        end
      else
        to_enum(:combination, k)
      end
    end

  end

end

