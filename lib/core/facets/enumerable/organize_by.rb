module Enumerable

  # Similar to #group_by but returns an array of the groups.
  # Returned elements are sorted by block.
  #
  #    %w{this is a test}.organize_by {|x| x[0]}
  #    #=> [ ['a'], ['is'], ['this', 'test'] ]
  #
  # CREDIT: Erik Veenstra

  def organize_by(&b)
    group_by(&b).sort.transpose.pop || []   # group_by(&b).values ?
  end

  # DEPRECATED: Name changed to avoid confusion with #cluster.
  alias cluster_by organize_by

end

