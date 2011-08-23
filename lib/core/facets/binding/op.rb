require 'facets/binding/eval'

class Binding

  # Returns the value of some variable.
  #
  #   a = 2
  #   binding["a"]  #=> 2
  #
  def []( x )
    eval( x.to_s )
  end

  # Set the value of a local variable.
  #
  #   binding["a"] = 4
  #   a  #=> 4
  #
  def []=( l, v )
    eval( "lambda {|v| #{l} = v}").call( v )
  end

end

