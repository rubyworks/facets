covers 'facets/kernel/object_class'
covers 'facets/kernel/__class__'

testcase Kernel do

  unit :object_class do
    self.object_class.assert == self.class
  end

  unit :__class__ do
    self.__class__.assert == self.class
  end

end
