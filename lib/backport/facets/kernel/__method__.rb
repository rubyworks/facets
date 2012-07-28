module Kernel

  unless defined?(__method__) == "method"  # 1.8.7+

    # Retreive the current running method name.
    #
    #   def method_example
    #     __method__
    #   end
    #
    #   method_example  #=> :method_example
    #
    # Technically __callee__ should provided alias names,
    # where __method__ should not. But we'll have to
    # leave that distinction to Ruby 1.9+.

    def __method__
      /\`([^\']+)\'/.match(caller(1).first)[1].to_sym
    end

    private :__method__

  end

  unless defined?(__callee__) == "method"  # 1.9+

    # Retreive the current running method name.
    #
    #   def callee_example
    #     __callee__
    #   end
    #
    #   callee_example  #=> :callee_example
    #
    # Technically __callee__ should provided alias names,
    # where as __method__ should not. But we'll have to
    # leave that distinction to Ruby 1.9+.

    def __callee__
      /\`([^\']+)\'/.match(caller(1).first)[1].to_sym
    end

    private :__callee__

  end

end

