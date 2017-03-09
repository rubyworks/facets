class Class

  if defined?(Class.__subclasses__) # Rubinius

    # Returns an array with the direct children of +self+.
    #
    #   Integer.subclasses # => [Fixnum, Bignum]
    #
    alias_method :subclasses, :__subclasses__

  else

    # Returns an array with the direct children of +self+.
    #
    #   Integer.subclasses # => [Fixnum, Bignum]
    #
    def subclasses # :nodoc:
      ObjectSpace.each_object(singleton_class).select do |k|
        k != self
      end
    end

  end

end

