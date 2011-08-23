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
    def subclasses
      list = []
      ObjectSpace.each_object(Class) do |c|
        list.unshift c if c.superclass == self
      end
      list.uniq
    end

  end

end

