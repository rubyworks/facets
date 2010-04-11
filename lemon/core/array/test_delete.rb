require 'facets/array/delete'

TestCase Array do

  Unit :delete_unless do
    a = [1,2,3]
    a.delete_unless{ |e| e == 2 }
    a.assert == [2]
  end

  Unit :delete_values do
    a = [1,2,3,4]
    a.delete_values(1,2).assert == [1,2]
    a.assert == [3,4]
  end

  Unit :delete_values_at do
    a = [1,2,3,4]
    a.delete_values_at(1,2).assert == [2,3]
    a.assert == [1,4]
    a = [1,2,3,4]
    a.delete_values_at(0..2).assert == [1,2,3]
    a.assert == [4]
  end

end

