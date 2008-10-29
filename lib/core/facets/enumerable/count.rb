unless (RUBY_VERSION[0,3] == '1.9')

  module Enumerable

    # Count the number of items in an enumerable
    # equal (==) to the given object.
    #
    #   e = [ 'a', '1', 'a' ]
    #   e.count('1')    #=> 1
    #   e.count('a')    #=> 2
    #
    # Count can also handle multiple-valued blocks.
    #
    #   e = { 'a' => 2, 'a' => 2, 'b' => 1 }
    #   e.count('a',2)  #=> 1
    #
    #   CREDIT: Trans

    def count(*c)
      self.select{ |*i| i == c }.length
    end

  end

end

