covers 'facets/kernel/__class__'

tests Kernel do

  unit :__class__ do
    o = Object.new
    o.__class__.assert == o.class
  end

end
