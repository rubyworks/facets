begin
  require 'enumerator' #if RUBY_VERSION < 1.9
  # for Ruby 1.8 -> 1.9 transition
  Enumerator = Enumerable::Enumerator unless defined? ::Enumerator

  class Enumerator

    alias :old_initialize :initialize

    # Provides the ruby-1.9 block form of Enumerator, where you can write:
    #
    #    obj = Enumerator.new do |yielder|
    #       .. do stuff
    #       yielder.yield data      # or: yielder << data
    #       .. etc
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
    #   assert_equal [1, 1, 2, 3, 5, 8, 13, 21, 34, 55], fib.take(10)
                                                  
    def initialize(*args, &block)
      if block_given?
        @body = block
        old_initialize(self, :_start)
      else
        old_initialize(*args)
      end
    end

    def _start(*args,&receiver) #:nodoc:
      @body.call(Yielder.new(receiver), *args)
    end

    # Wrapper to allow yielder.yield(output) or yielder << output
    # in the same way as ruby-1.9

    class Yielder #:nodoc:
      def initialize(proc)
        @proc = proc
      end
      def yield(*args)
        @proc[*args]
      end
      alias :<< :yield
    end

  end

rescue LoadError # Ruby 1.9 already has it built-in.
end

path = __FILE__.chomp('.rb')
base = File.basename(path)
Dir[File.join(path, '*.rb')].each do |lib|
  #require lib # why is this so much slower?
  require "facets/#{base}/#{File.basename(lib)}"
end

