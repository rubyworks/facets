module Kernel

  # Deep duplication of an object by deep duplication of every instance
  # variable as well.
  #
  # Returns [Object]

  def deep_dup(cache={})
    return cache[self] if cache.key?(self)

    copy = dup()
    cache[self] = copy

    copy.instance_variables.each do |var|
      val = instance_variable_get(var)
      begin
        val = val.deep_dup(cache)
      rescue TypeError
        next
      end
      copy.instance_variable_set(var, val)
    end

    return copy
  end

end
