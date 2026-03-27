module Kernel

  # Require a pattern of files relative to the current file.
  # This makes it easy to require an entire directory, for instance:
  #
  #   require_all 'core_ext/*'
  #

  def require_all(pattern)
    loc = caller_locations(1, 1).first
    file = loc.absolute_path || loc.path
    raise LoadError, "require_all is called in #{loc.label}" unless file
    glob = File.expand_path(pattern, File.dirname(file))
    Dir.glob(glob).each do |absolute|
      require absolute
    end
  end

  # Same as #require_all, but for #load.
  def load_all(pattern, safe=nil)
    loc = caller_locations(1, 1).first
    file = loc.absolute_path || loc.path
    raise LoadError, "load_all is called in #{loc.label}" unless file
    glob = File.expand_path(pattern, File.dirname(file))
    Dir.glob(glob).each do |absolute|
      load absolute, safe
    end
  end

end
