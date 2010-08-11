# for Ruby 1.8 -> 1.9 transition
unless defined?(::Enumerator)
  begin
    require 'enumerator'
    Enumerator = Enumerable::Enumerator unless defined? ::Enumerator
  rescue LoadError # Ruby 1.9 already has it built-in.
  end
end

require 'facets/functor'

class Enumerator

  #
  def fx
    Functor.new do |op, *a, &b|
      map{ |e| e.send(op, *a, &b) }
    end
  end

end

