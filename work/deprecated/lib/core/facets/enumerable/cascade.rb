module Enumerable

  #   # Cascade actions on each enumerated element.
  #   #
  #   #   [9, 19, 29].cascade :succ, :to_s, :reverse
  #   #   => ["01", "02", "03"]
  #   #
  #   # See ruby-talk:199877.
  #
  #   def cascade(*methods)
  #     methods.inject(self){ |ary, method| ary.map{ |x| x.send(method)}}
  #   end


  # DEPRECATED:
  #
  #   # Why the term counter? There may be a change in Ruby 2.0
  #   # to use this word instead of index. Index will
  #   # still be used for Array, since that is the proper meaning
  #   # in that context. In the mean time, aliases are provided.
  #
  #   alias_method( :collect_with_counter, :collect_with_index )
  #   alias_method( :map_with_counter, :collect_with_index )
  #
  #   #instance_map and #instance_select --too invasive for convenience.

end

