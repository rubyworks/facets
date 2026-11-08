# All definitions are confined to this standalone demonstration process.

# A top-level definition belongs to Object's private instance methods.
def greeting
  'hello'
end
raise 'wrong definition owner' unless method(:greeting).owner == Object
raise 'not a private Object method' unless Object.private_instance_methods(false).include?(:greeting)
raise 'missing inherited method' unless Object.new.send(:greeting) == 'hello'

define_method(:dynamic_greeting) { 'dynamic hello' }
raise 'top-level define_method failed' unless Object.new.send(:dynamic_greeting) == 'dynamic hello'

# The receiver of a declaration need not be the owner of the resulting method.
module Declarations
  def field(name)
    declared_on = self
    define_method(name) { declared_on }
  end
end

class Record
  extend Declarations
  field :declaration_context
end
raise 'wrong class context' unless Record.new.declaration_context.equal?(Record)

top = self
extend Declarations
field :top_context
raise 'wrong top-level context' unless Object.new.send(:top_context).equal?(top)
raise 'main unexpectedly equals Object' if top.equal?(Object)

# A self-extended module supplies a different namespace policy explicitly.
module MAIN
  extend self
  def namespaced_greeting
    'hello from MAIN'
  end
  define_method(:namespaced_dynamic) { 'dynamic MAIN' }
end
raise 'module call failed' unless MAIN.namespaced_greeting == 'hello from MAIN'
raise 'module dynamic definition failed' unless MAIN.namespaced_dynamic == 'dynamic MAIN'
raise 'namespace leaked into Object' if Object.private_instance_methods.include?(:namespaced_greeting)

class Consumer
  include MAIN
end
raise 'explicit inclusion failed' unless Consumer.new.namespaced_greeting == 'hello from MAIN'

# A library-owned loader can choose an isolated definition namespace today.
module SettingsDSL
  def option(name, default)
    define_method(name) { default }
  end
end

module ScriptLoader
  def self.load(source, filename = 'settings.rb')
    context = Module.new
    context.extend(context)
    context.extend(SettingsDSL)
    context.module_eval(source, filename, 1)
    context
  end
end

settings = ScriptLoader.load(<<~RUBY)
  option :port, 8080
  def label
    "demo"
  end
RUBY

raise 'option missing' unless settings.port == 8080
raise 'helper missing' unless settings.label == 'demo'
raise 'loader leaked option' if Object.private_instance_methods.include?(:port)
raise 'loader leaked helper' if Object.private_instance_methods.include?(:label)
other = ScriptLoader.load('option :port, 9090')
raise 'contexts share definitions' unless settings.port == 8080 && other.port == 9090

puts "Namespace examples passed on Ruby #{RUBY_VERSION}."
