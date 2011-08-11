covers 'facets/kernel/__dir__'

test_case Kernel do

  # TODO: can't test b/c somehow Lemon intefers with the call stack
  # which __DIR__ uses to locate the current running file.

  method :__DIR__ do

    omit "issue with call stack" do

      test "relative directory" do
        __DIR__.assert == File.dirname(__FILE__)
      end

      test  "relative directory joins with arguments" do
        __DIR__('tmp').assert == File.join(File.dirname(__FILE__), 'tmp')
      end

    end

  end

end
