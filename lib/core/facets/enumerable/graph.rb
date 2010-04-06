module Enumerable

  # Like <tt>#map</tt>/<tt>#collect</tt>, but generates a Hash. The block
  # is expected to return two values: the key and the value for the new hash.
  #
  #   numbers  = (1..3)
  #   squares  = numbers.graph{ |n| [n, n*n] }   # { 1=>1, 2=>4, 3=>9 }
  #   sq_roots = numbers.graph{ |n| [n*n, n] }   # { 1=>1, 4=>2, 9=>3 }
  #
  # CREDIT: Andrew Dudzik (adudzik), Trans

  def graph(&yld)
    if yld
      h = {}
      each do |*kv|
        r = yld[*kv]
        case r
        when Hash
          nk, nv = *r.to_a[0]
        when Range
          nk, nv = r.first, r.last
        else
          nk, nv = *r
        end
        h[nk] = nv
      end
      h
    else
      Enumerator.new(self,:graph)
    end
  end

  # Alias for #graph, which stands for "map hash".
  alias_method :mash, :graph

end

