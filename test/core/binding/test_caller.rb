covers 'facets/binding/caller'

test_case Binding do

  a = 1
  b = 2
  x = "hello"
  
  bind = binding
  line = __LINE__  # the line number must be updated if it moves
  file = __FILE__  # why does it equal basename only?

  method :__LINE__ do
    test do
      bind.__LINE__.assert == line - 1
    end
  end

  method :__FILE__ do
    test do
      bind.__FILE__.assert == file
    end
  end

  method :__DIR__ do
    test do
      bind.__DIR__.assert == File.dirname(file)
    end
  end

  method :callstack do
    test do
      bind.callstack.assert.is_a?(Array)
    end
  end

  method :call_stack do
    test do
      bind.call_stack.assert.is_a?(Array)
    end
  end

  method :caller do
    test do
      Exception.refute.raised? do
        bind.caller
      end
    end
  end

  method :__callee__ do
    test do
      alternate.__callee__.assert == :alternate
    end
  end

  method :__method__ do
    test do
      alternate.__method__.assert == :alternate
    end
  end

  # helper method
  def alternate
    binding
  end

end

