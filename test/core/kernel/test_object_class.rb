covers 'facets/kernel/object_class'
covers 'facets/kernel/__class__'

test_case Kernel do

  method :object_class do

    test do
      self.object_class.assert == self.class
    end

  end

  method :__class__ do

    test do
      self.__class__.assert == self.class
    end

  end

end
