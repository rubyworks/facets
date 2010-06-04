require 'facets/functor'

module Kernel

  if RUBY_VERSION > '1.8.6'

    # Inversion functor.
    #
    #   true.not.nil?  #=> true
    #
    def not
      Functor.new do |op, *a, &b|
        !__send__(op, *a, &b)
      end
    end

  else

    #
    def not
      Functor.new do |op, *a|
        !__send__(op, *a)
      end
    end

  end

  # Same as using NOT operator '!'.
  #
  #  true.nil?.not? == !true.nil?
  #
  def not?
    !self
  end

end

