Covers 'facets/kernel/object_class'
Covers 'facets/kernel/__class__'

Case Kernel do

  Unit :object_class do
    self.object_class.assert == self.class
  end

  Unit :__class__ do
    self.__class__.assert == self.class
  end

end
