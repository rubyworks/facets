class Module
  # Converts module methods into instance methods such that the first parameter
  # is passed +self+. This promotes DRY programming when wishing to offer both
  # inheritable and module callable procedures.
  #
  # This method is modeled after +module_function+ which essentially has the the
  # opposite effect. Due to implementation limitations, this must use the callback
  # #singleton_method_added to emulate +module_function+ when no method names
  # are given.
  #
  #   module MyModule
  #     instance_function
  #
  #     def self.jumble( obj, arg )
  #       obj + arg
  #     end
  #   end
  #
  #   class String
  #     include MyModule
  #   end
  #
  #   MyModule.jumble( "Try", "Me" )  #=> "TryMe"
  #
  #   "Try".jumble( "Me" )            #=> 'TryMe'
  #
  # Note: This used to be a module called PromoteSelf and later Instantize,
  # before becoming a method.
  #
  def instance_function(*meths)
    this = self
    if meths.empty?
      extend InstanceFunction
    else
      meths.each do |meth|
        module_eval do
          define_method(meth) do |*args|
            this.__send__(meth, self, *args)
          end
        end
        #class_eval %{
        #  def #{meth}(*args)
        #    #{self.name}.#{meth}(self,*args)
        #  end
        #}
      end
    end
  end

  module InstanceFunction #:nodoc
    #
    def singleton_method_added(meth)
      this = self
      #module_eval %{
      #  def #{meth}(*args)
      #    #{self.name}.#{meth}(self,*args)
      #  end
      #}
      module_eval do
        define_method(meth) do |*args|
          this.__send__(meth, self, *args)
        end
      end
      super(meth)
    end
  end

end #class Module


=begin
module Instantize

  def self.append_features(mod)
    mod.extend self
  end

  def singleton_method_added( meth )
    d = %{
      def #{meth}(*args)
        #{self.name}.#{meth}(self,*args)
      end
    }
    self.class_eval d
    super(meth)
  end

end
=end

