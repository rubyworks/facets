require 'facets/enumerator'

module Find

  # Identical to find except select returns the matching files as an array.
  # (find returns nil, which is not very useful if you actually wanted an array.)
  # Calls the associated block with the name of every file and directory listed
  # as arguments, then recursively on their subdirectories, and so on.
  # Return a true (non-false) value from the block for every path that
  # you want to be returned in the resulting array. You can still use Find.prune.
  #
  # CREDIT: Tyler Rick
  def self.select(*paths, &block)
    Enumerator.new(self, :find, *paths).select{|value| yield value}
  end
end

