module Enumerable

  # Take an associative array and unassociate it.
  #
  #   [[:a,1], [:b,2]].unassociate.to_a     #=> [:a, [1], :b, [2]]
  #   [[:a,1], [:b,2]].unassociate(1).to_a  #=> [:a, 1, :b, 2]
  #
  def unassociate(index = 1..-1)
    return to_enum(:unassociate, index) unless block_given?

    each do |v|
      case v
      when Array
        yield v[0]
        yield v[index]
      else
        yield v
        yield nil
      end
    end
  end

end
