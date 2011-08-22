require 'facets/math/lgamma'

module Math

  unless defined?(gamma)
    #
    def self.gamma(x)
      exp(lgamma(x))
    end
  end

end
