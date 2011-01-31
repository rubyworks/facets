module Kernel

  # Anything that can be marshaled can be copied in totality.
  #
  #   "ABC".deep_copy  #=> "ABC"
  #
  # NOTE: Not sure why we wouldn't just call this #copy, but
  # the term +deep_copy+ seems to be the common practive.
  def deep_copy
    Marshal::load(Marshal::dump(self))
  end

  #
  def deep_clone(cache={})
    return cache[self] if cache.key?(self) #@deep_cloning_obj if @deep_cloning
    copy = clone
    cache[self] = copy #@deep_cloning_obj = clone
    copy.instance_variables.each do |var|
      val = instance_variable_get(var)
      begin
        #@deep_cloning = true
        val = val.deep_clone(cache)
      rescue TypeError
        next
      ensure
        #@deep_cloning = false
      end
      copy.instance_variable_set(var, val)
      #@deep_cloning_obj.instance_variable_set(var, val)
    end
    #deep_cloning_obj = @deep_cloning_obj
    #@deep_cloning_obj = nil
    #deep_cloning_obj
    copy
  end

end

