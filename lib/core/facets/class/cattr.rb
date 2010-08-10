class Class

  # Creates a class-variable attribute that can
  # be accessed both on an instance and class level.
  #
  # NOTE This used to be a Module method. But turns out
  # it does not work as expected when included. The class-level
  # method is not carried along. So it is now just a Class
  # method. Accordingly, #mattr has been deprecated.
  #
  # CREDIT: David Heinemeier Hansson
  def cattr( *syms )
    writers, readers = syms.flatten.partition{ |a| a.to_s =~ /=$/ }
    writers = writers.collect{ |e| e.to_s.chomp('=').to_sym }
    readers.concat( writers ) # writers also get readers
    cattr_writer( *writers )
    cattr_reader( *readers )
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
  # CREDIT: David Heinemeier Hansson
  def cattr_reader( *syms )
    syms.flatten.each do |sym|
      class_eval(<<-EOS, __FILE__, __LINE__)
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
  # CREDIT: David Heinemeier Hansson
  def cattr_writer(*syms)
    syms.flatten.each do |sym|
      class_eval(<<-EOS, __FILE__, __LINE__)
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
  # CREDIT: David Heinemeier Hansson
  def cattr_accessor(*syms)
    cattr_reader(*syms) + cattr_writer(*syms)
  end

end

#--
# TODO: Look into #mattr usage more to be sure of this.
# Not properly applicable to modules, so these have been deprecated.
#class Module
#  alias_method :mattr,          :cattr            # deprecate
#  alias_method :mattr_reader,   :cattr_reader     # deprecate
#  alias_method :mattr_writer,   :cattr_writer     # deprecate
#  alias_method :mattr_accessor, :cattr_accessor   # deprecate
#end
#++

