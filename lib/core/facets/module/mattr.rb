class Module

  # Creates a class-variable attribute that can
  # be accessed both on an instance and class level.
  #
  #   class CARExample
  #     @@a = 10
  #     cattr :a
  #   end
  #
  #   CARExample.a           #=> 10
  #   CARExample.new.a       #=> 10
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: David Heinemeier Hansson
  #
  # @uncommon
  #   require 'facets/module/cattr'
  #
  def cattr(*syms, &block)
    writers, readers = syms.flatten.partition{ |a| a.to_s =~ /=$/ }
    writers = writers.map{ |e| e.to_s.chomp('=').to_sym }
    ##readers.concat( writers ) # writers also get readers

    cattr_reader(*readers, &block)
    cattr_writer(*writers, &block)

    return readers + writers
  end

  # Creates a class-variable attr_reader that can
  # be accessed both on an instance and class level.
  #
  #   class CARExample
  #     @@a = 10
  #     cattr_reader :a
  #   end
  #
  #   CARExample.a           #=> 10
  #   CARExample.new.a       #=> 10
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: David Heinemeier Hansson
  #
  # @uncommon
  #   require 'facets/module/cattr'
  #
  def cattr_reader(*syms, &block)
    syms.flatten.each do |sym|
      module_eval(<<-EOS, __FILE__, __LINE__)
        unless defined? @@#{sym}
          @@#{sym} = nil
        end

        def self.#{sym}
          @@#{sym}
        end

        def #{sym}
          @@#{sym}
        end
      EOS
      class_variable_set("@@#{sym}", block.call) if block
    end
    return syms
  end

  # Creates a class-variable attr_writer that can
  # be accessed both on an instance and class level.
  #
  #   class CAWExample
  #     cattr_writer :a
  #     def self.a
  #       @@a
  #     end
  #   end
  #
  #   CAWExample.a = 10
  #   CAWExample.a            #=> 10
  #   CAWExample.new.a = 29
  #   CAWExample.a            #=> 29
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: David Heinemeier Hansson
  #
  # @uncommon
  #   require 'facets/module/cattr'
  #
  def cattr_writer(*syms, &block)
    syms.flatten.each do |sym|
      module_eval(<<-EOS, __FILE__, __LINE__)
        unless defined? @@#{sym}
          @@#{sym} = nil
        end

        def self.#{sym}=(obj)
          @@#{sym} = obj
        end

        def #{sym}=(obj)
          @@#{sym}=(obj)
        end
      EOS
      class_variable_set("@@#{sym}", block.call) if block
    end
    return syms
  end

  # Creates a class-variable attr_accessor that can
  # be accessed both on an instance and class level.
  #
  #   class CAAExample
  #     cattr_accessor :a
  #   end
  #
  #   CAAExample.a = 10
  #   CAAExample.a           #=> 10
  #   mc = CAAExample.new
  #   mc.a                   #=> 10
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: David Heinemeier Hansson
  #
  # @uncommon
  #   require 'facets/module/cattr'
  #
  def cattr_accessor(*syms, &block)
    cattr_reader(*syms, &block) + cattr_writer(*syms)
  end

  # Creates a class-variable attribute that can
  # be accessed both on an instance and class level.
  #
  #   c = Class.new do
  #     mattr :a
  #     def initialize
  #       @@a = 10
  #     end
  #   end
  #
  #   c.new.a       #=> 10
  #   c.a           #=> 10
  #
  # NOTE: The #mattr methods may not be as useful for modules as the #cattr
  # methods are for classes, becuase class-level methods are not "inherited"
  # across the metaclass for included modules.
  #
  # NOTE: This methiod is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: David Heinemeier Hansson
  #
  # @uncommon
  #   require 'facets/module/mattr'
  #
  def mattr(*syms, &block)
    writers, readers = syms.flatten.partition{ |a| a.to_s =~ /=$/ }
    writers = writers.collect{ |e| e.to_s.chomp('=').to_sym }
    ##readers.concat( writers ) # writers also get readers

    mattr_writer( *writers, &block )
    mattr_reader( *readers, &block )

    return readers + writers
  end

  # Creates a class-variable attr_reader that can
  # be accessed both on an instance and class level.
  #
  #   c = Class.new do
  #     @@a = 10
  #     mattr_reader :a
  #   end
  #
  #   c.a           #=> 10
  #   c.new.a       #=> 10
  #
  # NOTE: This methiod is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: David Heinemeier Hansson
  #
  # @uncommon
  #   require 'facets/module/mattr'
  #
  def mattr_reader( *syms, &block )
    syms.flatten.each do |sym|
      module_eval(<<-EOS, __FILE__, __LINE__)
        unless defined? @@#{sym}
          @@#{sym} = nil
        end

        def self.#{sym}
          @@#{sym}
        end

        def #{sym}
          @@#{sym}
        end
      EOS
      class_variable_set("@@#{sym}", block.call) if block
    end
    return syms
  end

  # Creates a class-variable attr_writer that can
  # be accessed both on an instance and class level.
  #
  #   c = Class.new do
  #     mattr_writer :a
  #     def self.a
  #       @@a
  #     end
  #   end
  #
  #   c.a = 10
  #   c.a            #=> 10
  #
  #   c.new.a = 29
  #   c.a            #=> 29
  #
  # NOTE: This methiod is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: David Heinemeier Hansson
  #
  # @uncommon
  #   require 'facets/module/mattr'
  #
  def mattr_writer(*syms, &block)
    syms.flatten.each do |sym|
      module_eval(<<-EOS, __FILE__, __LINE__)
        unless defined? @@#{sym}
          @@#{sym} = nil
        end

        def self.#{sym}=(obj)
          @@#{sym} = obj
        end

        def #{sym}=(obj)
          @@#{sym}=(obj)
        end
      EOS
      class_variable_set("@@#{sym}", block.call) if block
    end
    return syms
  end

  # Creates a class-variable attr_accessor that can
  # be accessed both on an instance and class level.
  #
  #   c = Class.new do
  #     mattr_accessor :a
  #   end
  #
  #   c.a = 10
  #   c.a           #=> 10
  #
  #   x = c.new
  #   x.a           #=> 10
  #
  # NOTE: This methiod is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: David Heinemeier Hansson
  #
  # @uncommon
  #   require 'facets/module/mattr'
  #
  def mattr_accessor(*syms, &block)
    mattr_reader(*syms, &block) + mattr_writer(*syms)
  end

end

# Consider the issue where a module's metaclass is not inherited.
#
#   m = Module.new do
#     @@a = 10
#     mattr_reader :a
#   end
#
#   c = Class.new do
#     include m
#   end
#
#   expect NoMethodError do
#     c.a
#   end
#
# Ideally this would work.
