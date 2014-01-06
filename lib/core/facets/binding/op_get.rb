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
  # @deprecated No longer wortks in Ruby 1.9+.
  #
  # @see Binding#with for an alternative.
  def []=( l, v )
    eval( "lambda {|v| #{l} = v}").call( v )
  end

end

