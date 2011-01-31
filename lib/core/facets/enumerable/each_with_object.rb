module Enumerable

  unless method_defined?(:each_with_object)

    # A variation of #inject that saves one from having to
    # return the aggregate/memo argument.
    #
    # Say we want to count characters in a string. Using
    # the #each_with_object method we have:
    #
    #    "string".each_with_object(Hash.new(0)) do |c, h|
    #      h[c] += 1
    #    end
    #
    # versus using #inject which would be:
    #
    #    "string".inject(Hash.new(0)) do |h, c|
    #      h[c] +=1
    #      h
    #    end
    #
    # Notice that the order of the block parameters is reversed.
    #
    # This method used be called #injecting and had the same
    # parameter order as #inject, but Ruby 1.9 has adopted this
    # method, so we support it instead.

    def each_with_object(memo) #:yield:
      each do |element|
        yield(element, memo)
      end
      memo
    end

  end

end

