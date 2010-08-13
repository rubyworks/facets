covers 'facets/binding/caller'

tests Binding do

  a = 1
  b = 2
  x = "hello"
  
  bind = binding
  line = __LINE__  # the line number must be updated if it moves
  file = __FILE__  # why does it equal basename only?

  unit :__LINE__ do
    bind.__LINE__.assert == line - 1
  end

  unit :__FILE__ do
    bind.__FILE__.assert == file
  end

  unit :__DIR__ do
    bind.__DIR__.assert == File.dirname(file)
  end

  unit :callstack do
    bind.callstack.assert.is_a?(Array)
  end

  unit :call_stack do
    bind.call_stack.assert.is_a?(Array)
  end

  unit :caller do
    Exception.refute.raised? do
      bind.caller
    end
  end

  unit :__callee__ do
    alternate.__callee__.assert == :alternate
  end

  unit :__method__ do
    alternate.__method__.assert == :alternate
  end

  def alternate
    binding
  end

end

