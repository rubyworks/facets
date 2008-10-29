require 'facets/enumerable/probability'

module Enumerable

  # Shannon's entropy for an array - returns the average
  # bits per symbol required to encode the array.
  # Lower values mean less "entropy" - i.e. less unique
  # information in the array.
  #
  #   %w{ a b c d e e e }.entropy  #=>
  #
  #   CREDIT: Derek

  def entropy
    arr = to_a
    probHash = arr.probability
    # h is the Shannon entropy of the array
    h = -1.to_f * probHash.keys.inject(0.to_f) do |sum, i|
      sum + (probHash[i] * (Math.log(probHash[i])/Math.log(2.to_f)))
    end
    h
  end

  # Returns the maximum possible Shannon entropy of the array
  # with given size assuming that it is an "order-0" source
  # (each element is selected independently of the next).
  #
  #   CREDIT: Derek

  def ideal_entropy
    arr = to_a
    unitProb = 1.0.to_f / arr.size.to_f
    (-1.to_f * arr.size.to_f * unitProb * Math.log(unitProb)/Math.log(2.to_f))
  end

end

