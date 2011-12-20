covers 'facets/tuple'

test_case Tuple do

  class_method :[] do
    test "tuples with same content are the same object" do
      t1 = Tuple[1,2,3]
      t2 = Tuple[1,2,3]
      t1.object_id.assert == t2.object_id
    end
  end

  method :< do
    test do
      t1 = Tuple[1,2,3]
      t2 = Tuple[2,4,5]
      t1.assert < t2
    end
  end

  method :> do
    test do
      t1 = Tuple[1,2,3]
      t2 = Tuple[2,4,5]
      t2.assert > t1
    end
  end

  method :to_a do
    test do
      t1 = Tuple[1,2,3]
      a1 = t1.to_a
      assert( Array === a1 )
    end
  end

  method :<< do
    test do
      t1 = Tuple[1,2,3]
      t1 = t1 << 4
      t1.assert.is_a? Tuple
      t2 = Tuple[1,2,3,4]
      t1.object_id.assert == t2.object_id
    end
  end

end

test_case String do

  method :to_t do
    test do
      t1 = "1.2.3".to_t
      t1.assert.is_a? Tuple
      t2 = Tuple[1,2,3]
      t1.object_id.assert == t2.object_id
    end

    test do
      t1 = "1.2.3a".to_t
      t1.assert.is_a? Tuple
      t2 = Tuple[1,2,'3a']
      t1.assert == t2
      t1.object_id.assert == t2.object_id
    end
  end

end
