class Class

  # Rubinius
  if defined?(Class.__subclasses__)

    # Returns an array with the direct children of +self+.
    #
    #   Integer.subclasses # => [Bignum, Fixnum]
    #
    alias_method :subclasses, :__subclasses__

  else

    # Returns an array with the direct children of +self+.
    #
    #   Integer.subclasses # => [Bignum, Fixnum]
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

