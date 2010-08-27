covers 'facets/kernel/__dir__'

tests Kernel do

  concern "can't test b/c somehow Lemon intefers with the call stack " +
          "which __DIR__ uses to locate the current running file."

  omit :__DIR__ do
    __DIR__.assert == File.dirname(__FILE__)
  end

  omit :__DIR__ => "with arguments" do
    __DIR__('tmp').assert == File.join(File.dirname(__FILE__), 'tmp')
  end

end
