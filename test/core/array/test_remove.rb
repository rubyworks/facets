covers 'facets/array/remove'

test_case Array do
  method :remove do
    test do
      a                         = [1,1,2,3]
      a.difference([1]).assert == [    2,3]
      (a -         [1]).assert == [    2,3]
      a.remove(    [1]).assert == [  1,2,3]
      a.assert                 == [1,1,2,3]
    end

    test do
      a                           = [1,1,2,3]
      (a -           [1]).assert == [    2,3]
      a.remove([1, 1, 1]).assert == [    2,3]
      a.assert                   == [1,1,2,3]
    end

    test 'example from Array#- docs' do
      a =  [ 1, 1, 2, 2, 3, 3, 4, 5 ]
      (a - [    1,    2,       4    ]).assert == [ 3, 3, 5 ]
      a.remove([1,    2,       4    ]).assert == [ 1, 2, 3, 3, 5 ]
    end

    test 'element that is not found' do
      a                     = [1,1,2,3]
      (a -     [4]).assert == [1,1,2,3]
      a.remove([4]).assert == [1,1,2,3]
      a.assert             == [1,1,2,3]
    end
  end

  method :remove! do
    test do
      a                      = [1,1,2,3]
      a.remove!([1]).assert == [  1,2,3]
      a.assert              == [  1,2,3]
    end
  end
end
