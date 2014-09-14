covers 'facets/enumerable/sum'

test_case Enumerable do

  method :sum do

    test do
      [1,2,3].sum.assert == 6
    end

    test 'with block' do
      a = [1.0, 2.1, 3.2].sum(&:to_i)
      a.assert == 6
    end

    test 'with identity' do
      a = [].sum(9)
      a.assert == 9

      a = [1].sum(9)
      a.assert == 10
    end

    test 'with identity and block' do
      # notice identity is not effected by the block
      a = [].sum(9.1, &:to_i)
      a.assert == 9.1

      a = [1.1].sum(9.1, &:to_i)
      a.assert == 10.1
    end

    test 'with non-numeral addition' do
      a = [[1],[2],[3]].sum([])
      a.assert == [1,2,3]
    end

  end

end
