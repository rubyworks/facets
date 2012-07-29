require 'facets/enumerable/group_by'

module Enumerable

  # Similar to #group_by but returns an array of the groups.
  # Returned elements are sorted by block.
  #
  #    %w{this is a test}.cluster_by {|x| x[0]}
  #    #=> [ ['a'], ['is'], ['this', 'test'] ]
  #
  # TODO: Rename Enumerable#cluster_by method.
  #
  # CREDIT: Erik Veenstra

  def cluster_by(&b)
    group_by(&b).sort.transpose.pop || []   # group_by(&b).values ?
  end

  # Clumps adjacent elements together.
  #
  # >> [2,2,2,3,3,4,2,2,1].cluster{|x| x}
  # => [[2, 2, 2], [3, 3], [4], [2, 2], [1]]
  #
  # @author Oleg K

  def cluster
    cluster = []
    each do |element|
      if cluster.last && yield(cluster.last.last) == yield(element)
        cluster.last << element
      else
        cluster << [element]
      end
    end
    cluster
  end

end

