module Enumerable

  # Generates a hash mapping each unique symbol in the array
  # to the absolute frequency it appears.
  #
  #  CREDIT: Brian Schröder

  def frequency
    #probs = Hash.new(0)
    #each do |e|
    #  probs[e] += 1
    #end
    #probs
    inject(Hash.new(0)){|h,v| h[v]+=1; h}
  end

end

