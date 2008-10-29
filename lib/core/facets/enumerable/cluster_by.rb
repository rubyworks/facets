require 'facets/enumerable/group_by'

module Enumerable

  # Similar to #group_by but returns an array of the groups.
  # Returned elements are sorted by block.
  #
  #    %w{this is a test}.cluster_by {|x| x[0]}
  #
  # _produces_
  #
  #    [ ['a'], ['is'], ['this', 'test'] ]
  #
  #  CREDIT Erik Veenstra

  def cluster_by(&b)
    group_by(&b).sort.transpose.pop || []   # group_by(&b).values ?
  end

end

