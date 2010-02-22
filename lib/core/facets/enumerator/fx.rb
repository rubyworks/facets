begin
  require 'enumerator' #if RUBY_VERSION < 1.9
  # for Ruby 1.8 -> 1.9 transition
  Enumerator = Enumerable::Enumerator unless defined? ::Enumerator
rescue LoadError # Ruby 1.9 already has it built-in.
end

require 'facets/functor'

class Enumerator

  #
  def fx
    Functor.new do |op, *a|
      each{ |e| e.send(op, *a) }
    end
  end

end

