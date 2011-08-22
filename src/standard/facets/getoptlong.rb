require 'getoptlong'

# = GetoptLong
#
# Ruby's standard GetoptLong class with an added DSL.
#
#   opts = GetoptLong.new do
#     reqs '--expect', '-x'
#     flag '--help', '-h'
#   end
#
# See GetoptLong::DSL for details.

class GetoptLong

  alias :init :initialize

  #
  def initialize(*arguments, &block)
    if block_given?
      raise ArgumentError unless arguments.empty?
      arguments = DSL.new(&block).arguments
    end
    init(*arguments)
  end

  # DSL-mode parser.
  class DSL
    attr :arguments

    def initialize(&block)
      @arguments = []
      instance_eval(&block)
    end

    #
    def flag(*opts)
      @arguments << (opts << GetoptLong::NO_ARGUMENT)
    end

    #
    def required(*opts)
      @arguments << (opts <<  GetoptLong::REQUIRED_ARGUMENT)
    end

    #
    alias :reqs :required

    #
    def optional(*opts)
      @arguments << (opts << GetoptLong::OPTIONAL_ARGUMENT)
    end

    #
    alias :opts :optional
  end

end

