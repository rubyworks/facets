require 'facets/dir/find'

class Dir

  # @deprecated Use Dir.find or Find.find instead.
  def self.recurse(path='.', &block)
    warn "Dir.recurse is deprecated. Use Dir.find or Find.find instead.", uplevel: 1
    Dir.find(path, &block)
  end

  # @deprecated Use Dir.find or Find.find instead.
  def self.ls_r(path='.', &block)
    warn "Dir.ls_r is deprecated. Use Dir.find or Find.find instead.", uplevel: 1
    Dir.find(path, &block)
  end

end
