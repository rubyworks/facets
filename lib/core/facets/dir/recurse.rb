require 'facets/dir/find'

class Dir

  # Recursively list every entry below +path+ (not +path+ itself),
  # yielding each one to the block if given.
  #
  # @deprecated Use Dir.find or Find.find instead.
  #   Scheduled for removal after 2027-09-30.
  def self.recurse(path='.', &block)
    warn "Dir.recurse is deprecated. Use Dir.find or Find.find instead. It will be removed after 2027-09-30.", uplevel: 1
    recurse_entries(path, &block)
  end

  # @deprecated Use Dir.find or Find.find instead.
  #   Scheduled for removal after 2027-09-30.
  def self.ls_r(path='.', &block)
    warn "Dir.ls_r is deprecated. Use Dir.find or Find.find instead. It will be removed after 2027-09-30.", uplevel: 1
    recurse_entries(path, &block)
  end

  # Dir.find yields +path+ first; the old #recurse did not include it.
  def self.recurse_entries(path, &block)
    list = Dir.find(path).drop(1)
    list.each(&block) if block
    list
  end
  private_class_method :recurse_entries

end
