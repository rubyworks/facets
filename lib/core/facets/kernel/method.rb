$FIRST_CLASS_METHODS = Hash.new{ |h,k| h[k] = {} }

module Kernel

  # Easy access to method as object, and they retain state.
  #
  #   def hello
  #     puts "Hello World!"
  #   end
  #
  #   m1 = method!(:hello)
  #
  #   def m1.annotate
  #     "simple example"
  #   end
  #
  #   m2 = method!(:hello)
  #   m2.annotate  #=> "simple example"
  #
  def method!(s)
    #( @__methods__ ||= {} )[s.to_sym] ||= method(s)
    $FIRST_CLASS_METHODS[self][s.to_sym] ||= method(s)
  end

end

#--
# Should 1st Class Methods be part of Ruby proper?
#
# Perhaps the best solution would be using the notation
# <tt>::ameth</tt>. This would require some minor changes
# to Ruby, but with few backward incompatabilites if
# parantheticals revert back to the actual method invocation.
# Although this later stipulation means capitalized methods
# would not be accessible in this way b/c they would intefere with
# constant lookup. It's a trade off. ...
#
#                   Current           Proposed           Alternate
#                   ----------------- ------------------ -------------------
#     Foo.Bar()     method call       method call        method call
#     Foo.Bar       method call       method call        method call
#     Foo.bar()     method call       method call        method call
#     Foo.bar       method call       method call        method call
#     Foo::Bar()    method call       method call        1st class method
#     Foo::Bar      constant lookup   constant lookup    constant lookup
#     Foo::bar()    method call       method call        1st class method
#     Foo::bar      method call       1st class method   1st class method
#
# Then again this dosen't address bound versus unbound.
#++
