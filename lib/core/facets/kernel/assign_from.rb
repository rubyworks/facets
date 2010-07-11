module Kernel

  # Set attribute writers using like readers from another object.
  #
  #   class AssignExample
  #     attr_accessor :a, :b
  #     def initialize(a, b)
  #        @a, @b = a, b
  #     end
  #   end
  #
  #   obj1 = AssignExample.new(1,2)
  #   obj2 = AssignExample.new(3,4)
  #
  #   obj2.assign_from(obj1, :a, :b)
  #
  #   obj2.a  #=> 1
  #   obj2.b  #=> 2
  #
  # TODO: Should this be called #set_from ?

  def assign_from(obj, *fields)
    fields.each do |k|
      send("#{k}=", obj.__send__("#{k}"))  #if self.respond_to?("#{k}=") && obj.respond_to?("#{k}")
    end
  end

  # Original name for #assign_from.
  alias_method :set_from, :assign_from

end

