class Array

  # Get a list of all items that have something in common in terms of the
  # supplied block. If no block is given objects are considered to be in 
  # common if they return the same value for Object#hash and if obj1 == obj2.
  #
  # This can be useful, for instance, in determining all persons that share
  # their last name with another person.
  #
  #     persons.commonality { |person| person.last_name }
  #
  # The method is similar to #group_by which is a standard Ruby method as of 1.9.
  # To get effectively the same results with #group_by use `select{ |k,v| v.size > 1 }`.
  #
  #     [1, 2, 2, 3, 4, 4].group_by{ |e| e }.select{ |k,v| v.size > 1 }
  #     #=> { 2 => [2, 2], 4 => [4, 4] }
  #
  # Examples
  #
  #   [1, 2, 2, 3, 4, 4].commonality  #=> { 2 => [2, 2], 4 => [4, 4] }
  #
  #   ["foo", "bar", "baz"].commonality { |str| str[0] }
  #   #=> { 'b' => ["bar", "baz"] }
  #
  # Returns [Hash] mapping common attribute to those elements. 
  #
  # CREDIT: Florian Gross

  def commonality(&block)
    block ||= lambda { |item| item }

    result = Hash.new { |hash, key| hash[key] = Array.new }
    each do |item|
      key = block.call(item)
      result[key] << item
    end

    result.reject! do |key, values|
      values.size <= 1
    end

    return result
  end

  # Deprecated: Alias for #commonality.
  alias collisions commonality

end

