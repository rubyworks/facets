require 'facets/math/theil_index'

module Math

  # Closely related to the Theil index and easily expressible
  # in terms of it.
  #
  # AI = 1-e^{theil_index}
  #
  # http://en.wikipedia.org/wiki/Atkinson_index
  def self.atkinson_index(array)
    t = theil_index(array)
    (t < 0) ? -1 : 1-Math::E**(-t)
  end

end
