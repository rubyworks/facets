module Kernel

  # @deprecated Use require_relative for requires; for load, use
  #   an absolute path via File.expand_path.
  #   Scheduled for removal after 2027-09-30.
  def load_relative(relative_feature, safe=nil)
    warn "Kernel#load_relative is deprecated. It will be removed after 2027-09-30.", uplevel: 1
    loc = caller_locations(1, 1).first
    file = loc.absolute_path || loc.path
    absolute = File.expand_path(relative_feature, File.dirname(file))
    load absolute, safe
  end

end
