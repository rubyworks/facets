module Math

  # The Kullback-Leibler divergence from this array to that of +q+.
  #
  # NB: You will possibly want to sort both P and Q before calling this
  # depending on what you're actually trying to measure.
  #
  # http://en.wikipedia.org/wiki/Kullback-Leibler_divergence
  #
  def self.kldivergence(array, q)
    fail "Buggy."
    fail "Cannot compare differently sized arrays." unless size = q.size
    kld = 0
    each_with_index { |pi,i| kld += pi*Math::log(pi.to_f/q[i].to_f) }
    kld
  end

end

