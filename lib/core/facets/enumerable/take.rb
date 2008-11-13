module Enumerable

  if RUBY_VERSION < "1.9"

    # Return the first n items from the collection
    #
    def take(n)
      res = []
      count = 0
      each do |e|
        break if count >= n
        res << e
        count += 1
      end
      res
    end

  end

end
