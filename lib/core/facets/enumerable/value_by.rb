module Enumerable
  # Create a hash whose keys are the enumerable's elements, with specified
  # values.
  #
  # If no block is given, the given parameter (default true) is used for
  # all values, e.g.:
  #
  #     [1,2,3].value_by{ true }     #=> {1=>true, 2=>true, 3=>true}
  #     [1,2,3].value_by{ "a" }      #=> {1=>"a", 2=>"a", 3=>"a"}
  #
  # If a block is given, each key's value is the result of running the
  # block for that key, e.g.:
  #
  #     [1,2,3].value_by{ |n| "a"*n }  #=> {1=>"a", 2=>"aa", 3=>"aaa"}
  #
  # @author Ronen Barzel
  #
  def value_by
    return to_enum(:value_by) unless block_given?

    h = {}
    each { |item| h[item] = yield(item) }
    h
  end
end
