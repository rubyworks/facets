class Module

  # Combine modules.
  #
  #   module APlus
  #     def a; "a"; end
  #   end
  #
  #   module BPlus
  #     def b; "b"; end
  #   end
  #
  #   CPlus = APlus + BPlus
  #
  #   class XPlus; include CPlus; end
  #
  #   XPlus.new.a    #=> "a"
  #   XPlus.new.b    #=> "b"
  #
  # Note that in the old version of traits.rb we cloned
  # modules and altered their copies...
  #
  #   def +(other)
  #     mod1 = other.clone
  #     mod2 = clone
  #     mod1.module_eval{ include mod2 }
  #   end
  #
  # Later it was realized that this thwarted the main
  # benefit that Ruby's concept of modules has over
  # traditional traits, inheritance.
  #
  # CREDIT: Thomas Sawyer, Robert Dober

  def +(other)
    base = self
    Module.new do
      include base
      include other
    end
  end

  # Subtract modules.
  #
  #   module AMinus
  #     def a; "a"; end
  #     def b; "b"; end
  #   end
  #
  #   CMinus = AMinus - [:a]
  #
  #   class XMinus; include CMinus; end
  #
  #   expect NameError do
  #     XMinus.new.a  #=> "a"
  #   end
  #
  #   XMinus.new.b    #=> "b"
  #
  # TODO: Should this use all instance methods, not just public?
  #
  # CREDIT: Thomas Sawyer, Robert Dober

  def -(other)
    instance_methods = instance_methods(true).map{|m| m.to_sym}
    case other
    when Array
      subtract = instance_methods & other.map{|m| m.to_sym}
    when Module
      subtract = instance_methods & other.instance_methods(true).map{|m| m.to_sym}  # false?
    when String, Symbol
      subtract = instance_methods & [other.to_sym]
    end
    base = self
    Module.new do
      include base
      subtract.each{ |x| undef_method x }
    end
  end

  # Rename methods.
  #
  #   module AStar
  #     def a; "a"; end
  #   end
  #
  #   BStar = AStar * { :a => :b }
  #
  #   class XStar; include BStar; end
  #
  #   XStar.new.b    #=> "a"
  #
  # CREDIT: Thomas Sawyer, Robert Dober

  def *(rename_map)
    base = self
    Module.new do
      include base
      rename_map.each do |from, to|
        alias_method to, from
        undef_method from
      end
    end
  end

end

