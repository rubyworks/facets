unless (RUBY_VERSION[0,3] == '1.9')

  class Array

    # Permutation provids the possible orders of an enumerable.
    # Each is indexed by a permutation number. The maximum number of
    # arrangements is the factorial of the size of the array.
    #
    #  CREDIT: Shin-ichiro Hara

    def permutation(n=size)
      if size < n or n < 0
      elsif n == 0
        yield([])
      else
        self[1..-1].permutation(n - 1) do |x|
          (0...n).each do |i|
            yield(x[0...i] + [first] + x[i..-1])
          end
        end
        self[1..-1].permutation(n) do |x|
          yield(x)
        end
      end
    end

  end

end

