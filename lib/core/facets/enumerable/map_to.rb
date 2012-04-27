module Enumerable

  # Map each element into another class via class constructor.
  #
  # @param [#new] to_class
  #   Generally a class, but any object that repsonds to #new.
  #
  def map_to(to_class)
    map{ |e| to_class.new(e) }
  end

end

