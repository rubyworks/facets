module Enumerable

  # Returns all items that are equal in terms of the supplied block.
  # If no block is given objects are considered to be equal if they
  # return the same value for Object#hash and if obj1 == obj2.
  #
  #   [1, 2, 2, 3, 4, 4].commonality # => { 2 => [2], 4 => [4] }
  #
  #   ["foo", "bar", "a"].commonality { |str| str.length }
  #   # => { 3 => ["foo, "bar"] }
  #
  #   # Returns all persons that share their last name with another person.
  #   persons.collisions { |person| person.last_name }
  #
  #   CREDIT: Florian Gross

  def commonality( &block )
    had_no_block = !block
    block ||= lambda { |item| item }
    result = Hash.new { |hash, key| hash[key] = Array.new }
    self.each do |item|
      key = block.call(item)
      result[key] << item
    end
    result.reject! do |key, values|
      values.size <= 1
    end
    #return had_no_block ? result.values.flatten : result
    return result
  end

end

