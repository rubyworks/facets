class Array

  # Produces an array of arrays of all possible combinations
  # of the given arrays in the positions given. (Imagine
  # it like a slot machine dial. This gives every combination
  # that could come up.)
  #
  #   a = %w|a b|
  #   b = %w|a x|
  #   c = %w|x y|
  #   Enumerable.combinations(a, b, c).each { |x| p x }
  #
  # produces
  #
  #   ["a", "a", "x"]
  #   ["a", "a", "y"]
  #   ["a", "x", "x"]
  #   ["a", "x", "y"]
  #   ["b", "a", "x"]
  #   ["b", "a", "y"]
  #   ["b", "x", "x"]
  #   ["b", "x", "y"]
  #
  #   CREDIT: Florian Gross

  def self.combinations(head, *rest)
    crest = rest.empty? ? [[]] : combinations(*rest)
    head.inject([]) { |combs, item|
      combs + crest.map { |comb| [item] + comb }
    }
  end

end
