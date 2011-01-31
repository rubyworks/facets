module Kernel

  # Require a pattern of files relatvie to the current file.
  # This makes is easy to require an entire directory, for instance:
  #
  #   require_all 'core_ext/*'
  #
  # NOTE: This method used to allow glob-based requires from the $LOAD_PATH,
  # but this was deprecated in favor of relative requiring only, as it is
  # consider the typical usecase, and globbing from the $LOAD_PATH is a
  # bit dangerous. Better options exist for globbing the $LOAD_PATH such as
  # the +plugins+ gem.

  def require_all(pattern)
    c = caller.first
    fail "Can't parse #{c}" unless c.rindex(/:\d+(:in `.*')?$/)
    file = $` # File.dirname(c)
    if /\A\((.*)\)/ =~ file # eval, etc.
      raise LoadError, "require_relative is called in #{$1}"
    end
    glob = File.expand_path(pattern, File.dirname(file))
    Dir.glob(glob).each do |absolute|
      require absolute
    end
  end

  # Same as #require_all, but for #load.
  def load_all(pattern, safe=nil)
    c = caller.first
    fail "Can't parse #{c}" unless c.rindex(/:\d+(:in `.*')?$/)
    file = $` # File.dirname(c)
    if /\A\((.*)\)/ =~ file # eval, etc.
      raise LoadError, "require_relative is called in #{$1}"
    end
    glob = File.expand_path(pattern, File.dirname(file))
    Dir.glob(glob).each do |absolute|
      load absolute, safe
    end
  end

end

