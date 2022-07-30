covers 'facets/array/indexes'

module IndexAllCommon
end

test_case Array do
  method :indexes do
    test "no argument or block" do
      %w[a b c].indexes.class.assert == Enumerator
      %w[a b c].indexes.to_a.assert == [0, 1, 2]
    end

    test "with argument, no match" do
      %w[a b c].indexes('z').assert == []
    end

    test "with block, no match" do
      %w[a b c].indexes {|x| x == 'z' }.assert == []
    end

    test "with nil argument, 1 match" do
      [1, nil, 3].indexes(nil).assert == [1]
    end

    test "with argument, 1 match" do
      [1, 2, 3].indexes(2).  assert == [1]
      %w[a b c].indexes('b').assert == [1]
    end

    test "with 2 arguments" do
      ArgumentError.assert.raised? {
        [1, 2, 3].indexes(1, 2)
      }
    end

    test "with block, 1 match" do
      [1, 2, 3].indexes {|x| x == 2 }.assert == [1]
      %w[a b c].indexes {|x| x.upcase == 'B' }.assert == [1]
    end

    test "with argument and block, 1 match" do
      # This should raise an error, but for now ignoring the block to maintain behavior as close to
      # index as possible.
      [1, 2, 3].indexes(2)   {|x| x == 1 }.assert == [1]
      %w[a b c].indexes('b') {|x| x.upcase == 'A' }.assert == [1]
    end

    test "with argument, 2 matches" do
      [1, 2, 2].    indexes(2).assert == [1, 2]
      [1,2,2,3,3,3].indexes(2).assert == [1, 2]
      [1,2,2,3,3,3].indexes(3).assert == [3, 4, 5]
      %w[a b B c].indexes {|x| x.upcase == 'B' }.assert == [1, 2]
    end
  end

  method :index_all do
    test "with argument, 1 match" do
      [1, 2, 3].index_all(2).  assert == [1]
      %w[a b c].index_all('b').assert == [1]
    end
  end
end

require 'delegate'
class AnEnumerable < SimpleDelegator
  include Enumerable
end

test_case Enumerable do
  method :indexes do
    test "no argument or block" do
      (?a..?c).indexes.class.assert == Enumerator
      (?a..?c).indexes.to_a.assert == [0, 1, 2]
    end

    test "with argument, no match" do
      (?a..?c).indexes('z').assert == []
    end

    test "with block, no match" do
      (?a..?c).indexes {|x| x == 'z' }.assert == []
    end

    test "with nil argument, 1 match" do
      AnEnumerable.new([1, nil, 3]).indexes(nil).assert == [1]
    end

    test "with argument, 1 match" do
      (1..3).  indexes(2).  assert == [1]
      (?a..?c).indexes('b').assert == [1]
    end

    test "with 2 arguments" do
      ArgumentError.assert.raised? {
        (1..3).indexes(1, 2)
      }
    end

    test "with block, 1 match" do
      (1..3).  indexes {|x| x == 2 }.assert == [1]
      (?a..?c).indexes {|x| x.upcase == 'B' }.assert == [1]
    end

    test "with argument and block, 1 match" do
      # This should raise an error, but for now ignoring the block to maintain behavior as close to
      # index as possible.
      (1..3).indexes(2) {|x| x == 1 }.assert == [1]
    end

    test "very large receiver, very many matches" do
      (1..2**5).indexes(2).first(1).assert == [1]
    end
  end

  method :index_all do
    test "very large receiver, very many matches" do
      (1..2**5).index_all(2).first(1).assert == [1]
    end
  end
end

test_case Enumerator::Lazy do
  method :indexes do
    test "no argument or block" do
      %w[a b c].lazy.indexes.class.assert == Enumerator::Lazy
      %w[a b c].lazy.indexes.to_a.assert == [0, 1, 2]
    end

    test "with argument, no match" do
      %w[a b c].lazy.indexes('z').force.assert == []
    end

    test "with block, no match" do
      %w[a b c].lazy.indexes {|x| x == 'z' }.force.assert == []
    end

    test "with nil argument, 1 match" do
      [1, nil, 3].lazy.indexes(nil).class.assert == Enumerator::Lazy
      [1, nil, 3].lazy.indexes(nil).force.assert == [1]
    end

    test "with argument, 1 match" do
      [1, 2, 3].lazy.indexes(2).  force.assert == [1]
      %w[a b c].lazy.indexes('b').force.assert == [1]
    end

    test "with 2 arguments" do
      ArgumentError.assert.raised? {
        (1..3).lazy.indexes(1, 2)
      }
    end

    test "with block, 1 match" do
      [1, 2, 3].lazy.indexes {|x| x == 2 }.force.assert == [1]
      %w[a b c].lazy.indexes {|x| x.upcase == 'B' }.force.assert == [1]
    end

    test "with argument, 2 matches" do
      [1, 2, 2].    lazy.indexes(2).force.assert == [1, 2]
      [1,2,2,3,3,3].lazy.indexes(2).force.assert == [1, 2]
      [1,2,2,3,3,3].lazy.indexes(3).force.assert == [3, 4, 5]
      %w[a b B c].lazy.indexes {|x| x.upcase == 'B' }.force.assert == [1, 2]
    end

    test "infinitely large enumerable" do
      (1..Float::INFINITY).lazy.indexes(2).first(1).assert == [1]
    end

    test "infinitely large enumerable, infinitely many matches" do
      (1..Float::INFINITY).lazy.indexes {|i| i.odd? }.class.assert == Enumerator::Lazy
      (1..Float::INFINITY).lazy.indexes {|i| i.odd? }.first(5).assert == [0, 2, 4, 6, 8]
      (1..Float::INFINITY).lazy.map {|i| i.odd? ? i - 1 : i }.map(&:to_s).indexes {|el| el.to_i.even? }.first(5).assert == [0, 1, 2, 3, 4]
    end
  end

  method :index_all do
    test "infinitely large enumerable, infinitely many matches" do
      (1..Float::INFINITY).lazy.index_all {|i| i.odd? }.class.assert == Enumerator::Lazy
      (1..Float::INFINITY).lazy.index_all {|i| i.odd? }.first(5).assert == [0, 2, 4, 6, 8]
    end
  end
end
