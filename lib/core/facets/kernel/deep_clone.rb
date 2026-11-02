module Kernel

  # Deep clone an object by deep cloning every instance
  # variable as well, along with the elements of an Array and
  # the values of a Hash.
  #
  #   a = [1, [2, [3]]]
  #   b = a.deep_clone
  #   b[1][1] << 4
  #   a  #=> [1, [2, [3]]]
  #
  # Hash keys are not copied: Ruby already copies and freezes String
  # keys, and a hash compared by identity needs the same key objects.
  # Other containers, such as Struct and Set, share their members with
  # the original.
  #
  # An object that is referenced more than once, including an object
  # that contains itself, is copied once.
  #
  # Returns [Object]

  def deep_clone(cache={}.compare_by_identity)
    return cache[self] if cache.key?(self)

    collection = (Array === self || Hash === self)

    # A frozen collection's copy is filled in first, then frozen.
    copy = collection ? clone(freeze: false) : clone
    cache[self] = copy

    deep = lambda do |val|
      begin
        val.deep_clone(cache)
      rescue TypeError
        val
      end
    end

    copy.instance_variables.each do |var|
      copy.instance_variable_set(var, deep[instance_variable_get(var)])
    end

    if collection
      if Array === copy
        copy.map!(&deep)
      else
        copy.transform_values!(&deep)
      end
      copy.freeze if frozen?
    end

    return copy
  end

end
