#######################################################################
# example_instance.rb
#
# Sample program to demonstrate extending an interface to an instance
# of a class. You can run this program via the 'rake example_instance'
# task. Modify as you see fit.
#######################################################################
require 'interface'

MyInterface = interface{
   required_methods :foo, :bar
}

class Foo
   def foo; end
   def bar; end
end

class Bar
end

f = Foo.new
f.extend(MyInterface)

b = Bar.new

# This will blow up
class << b
   include MyInterface
end