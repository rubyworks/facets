module Kernel

  # @deprecated Use require_relative for requires; for load, use
  #   an absolute path via File.expand_path.
  def load_relative(relative_feature, safe=nil)
    warn "Kernel#load_relative is deprecated.", uplevel: 1
    loc = caller_locations(1, 1).first
    file = loc.absolute_path || loc.path
    absolute = File.expand_path(relative_feature, File.dirname(file))
    load absolute, safe
  end

end
