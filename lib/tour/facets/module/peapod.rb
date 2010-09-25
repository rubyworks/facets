module Peapod

  def self.included(base)
    base.extend Self
    base.instance_methods(false).each do |meth|
      base.method_added(meth)
    end
  end

  module Self
    def peapod_module
      @peapod_module ||= Module.new
    end

    def method_added(meth)
      return if meth.to_s[-2,2] == ':-'
      alias_method "#{meth}:-", meth
      remove_method(meth)
      peapod_module.module_eval %{
        def #{meth}(*a,&b); __send__("#{meth}:-",*a,&b); end
      }
      include peapod_module
    end
  end

end

class Module
  def prepend(mod)
    include Peapod
    include mod
  end
end

# -- example --

class X
  def a; "Xa"; end
end

module M
  def a; "M" + super ; end
end

class X
  prepend M
end

p X.new.a

