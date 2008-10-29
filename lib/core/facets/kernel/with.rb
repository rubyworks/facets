module Kernel

  # Like returning but exectures the block
  # via instance_eval.
  #
  #   def foo
  #     with values = [] do
  #       self << 'bar'
  #       self << 'baz'
  #     end
  #   end
  #
  #   foo # => ['bar', 'baz']
  #
  def with(obj=self, &block)
    obj.instance_eval(&block)
  end

end

