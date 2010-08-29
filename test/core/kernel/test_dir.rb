covers 'facets/kernel/__dir__'

tests Kernel do

  # TODO: can't test b/c somehow Lemon intefers with the call stack
  # which __DIR__ uses to locate the current running file.

  omit unit :__DIR__ do
    __DIR__.assert == File.dirname(__FILE__)
  end

  omit unit :__DIR__ => "with arguments" do
    __DIR__('tmp').assert == File.join(File.dirname(__FILE__), 'tmp')
  end

end
