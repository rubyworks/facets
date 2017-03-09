covers 'facets/enumerable/with_position'

test_case Enumerable do

  method :with_position do

    test do
      a = 5.times.with_position.to_a
      
      item, position = a.first
      item.assert == 0
      assert position.first?
      refute position.middle?
      refute position.last?

      
      item, position = a[2]
      item.assert == 2
      assert position.middle?
      refute position.first?
      refute position.last?
      
      item, position = a.last
      item.assert == 4
      refute position.first?
      refute position.middle?
      assert position.last?
    end

    test do
      a = 1.times.with_position.to_a
      
      item, position = a.first
      item.assert == 0
      assert position.first?
      refute position.middle?
      assert position.last?
    end

  end

end
