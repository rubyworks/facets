if RUBY_VERSION < '1.9'

  require 'enumerator'

  # for Ruby 1.8 -> 1.9 transition
  Enumerator = Enumerable::Enumerator unless defined?(::Enumerator)

  class Enumerator

    private

    alias :old_initialize :initialize

    # Provides the ruby-1.9 block form of Enumerator, where you can write:
    #
    #    obj = Enumerator.new do |yielder|
    #      # ...
    #      yielder.yield(data)  # or: yielder << data
    #      # ...
    #    end
    #
    # When obj.each is called, the block is run once. It should call
    # yielder.yield with each item it wishes to generate.
    #
    # Example:
    #
    #   fib = Enumerator.new { |y|
    #     a = b = 1
    #     loop {   
    #       y << a
    #       a, b = b, a + b
    #     }
    #   }  
    #
    #   fib.take(10)  #=> [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    #                                                 
    def initialize(*args, &block)
      if block
        @body = block
        old_initialize(self, :_start)
      else
        old_initialize(*args)
      end
    end

    def _start(*args,&receiver) #:nodoc:
      @body.call(Yielder.new(&receiver), *args)
    end

    # Wrapper to allow yielder.yield(output) or yielder << output
    # in the same way as ruby-1.9
    #
    # TODO: Why can't Yielder take a block instead of a proc argument?

    class Yielder #:nodoc:
      def initialize(&proc)
        @proc = proc
      end
      def yield(*args)
        @proc[*args]
      end
      alias :<< :yield
    end

  end

end

path = __FILE__.chomp('.rb')
base = File.basename(path)
Dir[File.join(path, '*.rb')].each do |lib|
  #require lib # why is this so much slower?
  require "facets/#{base}/#{File.basename(lib)}"
end

