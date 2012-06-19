#######################################################################
# example_interface.rb
#
# Sample test script that demonstrates a typical interface. You can
# run this example via the 'rake example_interface' task. Modify this
# code as you see fit.
#######################################################################
require 'interface'

MyInterface = interface{
	required_methods :foo, :bar
}

class MyClass
	def foo; end
	def bar; end
	include MyInterface
end

=begin
# Raises an error until bar is defined
class Foo
	def foo
		puts "foo"
	end
end
=end