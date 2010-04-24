require 'facets/binding/caller.rb'

TestCase Binding do

  a = 1
  b = 2
  x = "hello"
  
  @bind = binding
  @line = __LINE__  # the line number must be updated if it moves
  @file = __FILE__  # why does it equal basename only?

  Unit :__LINE__ do
    @bind.__LINE__.assert == @line - 1
  end

  Unit :__FILE__ do
    @bind.__FILE__.assert == @file
  end

  Unit :__DIR__ do
    @bind.__DIR__.assert == File.dirname(@file)
  end

  Unit :callstack do
    @bind.callstack.assert.is_a?(Array)
  end

  Unit :caller do
    Exception.refute.raised? do
      @bind.caller
    end
  end

  # These only work for certain versions, which is okay.

  unless RUBY_VERSION < "1.9"
    Unit :__callee__ do
      alternate.__callee__.assert == :alternate
    end
  end

  unless RUBY_VERSION < "1.8.7"
    Unit :__method__ do
      alternate.__method__.assert == :alternate
    end
  end

  def alternate
    binding
  end

end

