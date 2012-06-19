#######################################################################
# example_sub.rb
#
# Sample program to demonstrate extending a sub-interface. You can
# run this program via the 'rake example_sub' task. Modify this code
# as you see fit.
#######################################################################
require 'interface'

module MyInterface
	extend Interface
	required_methods :foo, :bar
end
	
module MySubInterface
	extend Interface
	extend MyInterface
	required_methods :baz
end

class MyClass
	def baz; end
	def bar; end
	def foo; end
	include MySubInterface
end
	
=begin
# Raises an error
class MyClass
	def baz; end
	include MyInterface
end
=end