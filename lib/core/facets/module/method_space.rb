require 'facets/functor'
require 'facets/module/basename'

class Module

  # Create method namespaces, allowing for method
  # chains but still accessing the object's instance.
  #
  #   class A
  #     attr_writer :x
  #     method_space :inside do
  #       def x; @x; end
  #     end
  #   end
  #
  #   a = A.new
  #   a.x = 10
  #   a.inside.x  #=> 10
  #
  #   expect NoMethodError do
  #     a.x
  #   end
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: Pit Captain
  #
  # @uncommon
  #   require 'facets/module/method_space'
  #
  def method_space(name, mod=nil, &blk)

    ## If block is given then create a module, otherwise
    ## get the name of the module.
    if block_given?
      name = name.to_s
      raise ArgumentError if mod
      mod  = Module.new(&blk)
    else
      if Module === name
        mod = name
        name = mod.basename.downcase
      end
      mod  = mod.dup
    end

    ## Include the module. This is neccessary, otherwise
    ## Ruby won't let us bind the instance methods.
    include mod

    ## Save the instance methods of the module and
    ## replace them with a "transparent" version.
    methods = {}
    mod.instance_methods(false).each do |m|
      methods[m.to_sym] = mod.instance_method(m)
      mod.module_eval %{
        def #{m}(*a,&b)
          super(*a,&b)
        end
      }
      ##mod.instance_eval do
      ##  define_method(m)
      ##    super
      ##  end
      ##end
    end

    ## Add a method for the namespace that delegates
    ## via the Functor to the saved instance methods.
    define_method(name) do
      mtab = methods
      Functor.new do |op, *args|
        if meth = mtab[op.to_sym]
          meth.bind(self).call(*args)
        else
          #self.__send__(op, *args)
          raise NoMethodError, "undefined method `#{m}'"
        end
      end
    end
  end

  # Include a module via a specified space.
  #
  #   module T
  #     def t ; "HERE" ; end
  #   end
  #
  #   class X
  #     include_as :test => T
  #     def t ; test.t ; end
  #   end
  #
  #   X.new.t  #=> "HERE"
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/module/method_space'
  #
  def include_as(h)
    h.each{ |name, mod| method_space(name, mod) }
  end

end
