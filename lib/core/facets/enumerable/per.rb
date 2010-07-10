require 'facets/functor'

#--
# TODO: Consider Enumerator methods.
#++

module Enumerable

  if RUBY_VERSION < '1.8.7'

    # Per element meta-functor.
    #
    #   ([1,2,3].per(:map) + 3)     #=> [4,5,6]
    #   ([1,2,3].per(:select) > 1)  #=> [2,3]
    #
    # Using fluid notation.
    #
    #   ([1,2,3].per.map + 3)       #=> [4,5,6]
    #   ([1,2,3].per.select > 1)    #=> [2,3]
    #
    def per(enum_method=nil, *enum_args)
      if enum_method
        Permeator.new(self, enum_method, *enum_args)
      else
        Functor.new do |enumr_method, *enumr_args|
          Permeator.new(self, enumr_method, *enumr_args)
        end
      end
    end

    # Permeator is a Functor for operating over each element of an Enumearble.
    # (Note: This used to be called an Elementor.)
    #
    # TODO: With Ruby 1.9+ this would not be required, as it can be replaced
    # by a generic Functor, becuase then lambda definitions can pass blocks.
    #
    class Permeator #:nodoc:
      private(*instance_methods.select{|x| x !~ /^__/ })

      def initialize(enum_object, enum_method=nil, *enum_args)
        @enum_object = enum_object
        @enum_method = enum_method || :map
        @enum_args   = enum_args
      end

      def instance_delegate
        @enum_object
      end

      def instance_operator
        @enum_method
      end

      def method_missing(sym, *args, &blk)
        @enum_object.__send__(@enum_method){ |x| x.__send__(sym, *args, &blk) }
      end
    end

  else

    # Per element meta-functor.
    #
    #   ([1,2,3].per(:map) + 3)     #=> [4,5,6]
    #   ([1,2,3].per(:select) > 1)  #=> [2,3]
    #
    # Using fluid notation.
    #
    #   ([1,2,3].per.map + 3)       #=> [4,5,6]
    #   ([1,2,3].per.select > 1)    #=> [2,3]
    #
    def per(enum_method=nil, *enum_args)
      if enum_method
        Functor.new do |op, *args, &blk|
          __send__(enum_method, *enum_args){ |x| x.__send__(op, *args, &blk) }
        end
      else
        Functor.new do |enumr_method, *enumr_args|
          Functor.new do |op, *args, &blk|
            __send__(enumr_method, *enumr_args){ |x| x.__send__(op, *args, &blk) }
          end
        end
      end
    end

  end

end

