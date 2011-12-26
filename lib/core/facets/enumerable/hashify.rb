module Enumerable
  # Create a hash whose keys are the enumerable's elements, with specified
  # values.
  #
  # If no block is given, the given parameter (default true) is used for
  # all values, e.g.:
  #
  #     [1,2,3,4].hashify               #=> {1=>true, 2=>true, 3=>true, 4=>true}
  #     [1,2,3,4].hashify("a")          #=> {1=>"a", 2=>"a", 3=>"a", 4=>"a"}
  #
  # If a block is given, each key's value is the result of running the
  # block for that key, e.g.:
  #
  #     [1,2,3,4].hashify{|n| "a" * n}  #=> {1=>"a", 2=>"aa", 3=>"aaa", 4=>"aaaa"}
  #
  # @author Ronen Barzel
  #
  # @uncommon
  #   require 'facets/enumerable/hashify'
  #
  def hashify(val=true)
    h = {}
    if block_given?
      each { |item| h[item] = yield(item) }
    else
      each { |item| h[item] = val }
    end
    h
  end

end
