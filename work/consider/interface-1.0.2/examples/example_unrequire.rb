###########################################################################
# example_unrequire.rb
#
# Sample test script for to verify that unrequired_methods works properly.
# You can run this code via the 'rake example_unrequire' rake task. Modify
# this code as you see fit.
###########################################################################
require 'interface'

MyInterface = interface{
	required_methods :foo, :bar
}
	
# require foo and baz, but not bar
MySubInterface = interface{
	extends MyInterface
	required_methods :baz
	unrequired_methods :bar
}

# No error
class MyClass
	def foo; end
	def baz; end
	include MySubInterface
end