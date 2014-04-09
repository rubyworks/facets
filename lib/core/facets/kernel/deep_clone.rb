module Kernel

  # Deep clone an object by deep cloning every instance
  # variable as well.
  #
  # Returns [Object]

  def deep_clone(cache={})
    return cache[self] if cache.key?(self)

    copy = clone()
    cache[self] = copy

    copy.instance_variables.each do |var|
      val = instance_variable_get(var)
      begin
        val = val.deep_clone(cache)
      rescue TypeError
        next
      end
      copy.instance_variable_set(var, val)
    end

    return copy
  end

end
