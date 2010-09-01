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
    Functor.new(&method(:fx_send).to_proc)
  end

  private

  #
  def fx_send(op, *a, &b)
    map{ |e| e.send(op, *a, &b) }
  end

  ## TODO: When no longer needed to support 1.8.6 we can use:
  ##
  ## #
  ## def fx
  ##   Functor.new do |op, *a, &b|
  ##     map{ |e| e.send(op, *a, &b) }
  ##   end
  ## end

end

