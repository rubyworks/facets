# = Chain
#
# Expiremental library for safe method chaining.
#
#   person = "John Doe"
#   def person.address = "123 West St."
#   person.address.street #=> Error
#
# To avoid the error use #chain:
#
#   person.chain.address.street.end   #=> nil
#
# Or
#
#   ~ person.chain.address.street     #=> nil
#
class Chain

  private *instance_methods.select{|m| m !~ /^__/ }

  def initialize(value)
    @value = value
  end

  def method_missing(s,*a, &b)
    if @value.respond_to?(s)
      @value = @value.__send__(s,*a,&b)
    else
      @missing = true
    end
    #begin
    #  @value = @value.__send__(s,*a,&b)
    #rescue NoMethodError
    #  @missing = true
    #end
    self
  end

  #def value?
  #  @value
  #end

  def end
    @missing ? nil : @value
  end

  def ~@
    @missing ? nil : @value
  end

end

module Kernel
  def chain
    Chain.new(self)
  end
end

