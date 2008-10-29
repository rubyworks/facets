unless (RUBY_VERSION[0,3] == '1.9')

  module Enumerable

    # Enumerable#one? returns +true+ if and only if <em>exactly one</em>
    # element in the collection satisfies the given predicate.
    #
    # If no predicate is provided, Enumerable#one? returns +true+ if
    # and only if <em>exactly one</em> element has a true value
    # (i.e. not +nil+ or +false+).
    #
    #   [].one?                      # false
    #   [nil].one?                   # false
    #   [5].one?                     # true
    #   [5,8,9].one?                 # false
    #   (1...10).one? { |n| n == 5 } # true
    #   (1...10).one? { |n| n < 5 }  # false
    #
    #   CREDIT: Gavin Sinclair

    def one?  # :yield: e
      matches = 0
      if block_given?
        self.each do |e|
          if yield(e)
            matches += 1
            return false if matches > 1
          end
        end
        return (matches == 1)
      else
        one? { |e| e }
      end
    end

  end

end
