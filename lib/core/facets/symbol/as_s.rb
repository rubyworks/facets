require 'facets/functor'

class Symbol

  # TODO: Should Symbol#as_s be moved to functor gem?

  # Convert symbol to string, apply string method and convert
  # back to symbol via a fluent interface.
  #
  #   :HELLO.as_s.chomp('O')  #=> :HELL
  #
  def as_s
    Functor.new do |op, *a|
      to_s.send(op, *a).to_sym
    end
  end

end

