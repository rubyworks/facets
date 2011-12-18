require 'facets/functor'

module Kernel

  # Same as using NOT operator '!'.
  #
  #  true.nil?.not? == !true.nil?
  #
  def not?
    !self
  end

  # Inversion functor.
  #
  #   true.not.nil?  #=> true
  #
  def not
    Functor.new(&method(:not_send).to_proc)
  end

  ## TODO: When we no longer need to support 1.8.6 we can use:
  ## 
  ## def not
  ##   Functor.new do |op, *a, &b|
  ##     !__send__(op, *a, &b)
  ##   end
  ## end

  private

  #
  def not_send(op, *a, &b)
    !__send__(op, *a)
  end

end

