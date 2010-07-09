require 'facets/functor'

class Symbol

  # Convert symbol to string, apply string method and convert
  # back to symbol via a fluent interface.
  #
  #   :HELLO.as_s.downcase  #=> :hello
  #
  def as_s
    @re_s ||= Functor.new do |op, *a|
      to_s.send(op, *a).to_sym
    end
  end

end

