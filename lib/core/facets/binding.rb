# Load all Binding core extensions.

if RUBY_VERSION < '1.9'
  require "facets/binding/__callee__.rb"
  require "facets/binding/__method__.rb"
  require "facets/binding/call_stack.rb"
  require "facets/binding/caller.rb"
  require "facets/binding/callstack.rb"
  require "facets/binding/defined.rb"
  require "facets/binding/eval.rb"
  require "facets/binding/local_variables.rb"
  require "facets/binding/op.rb"
  require "facets/binding/self.rb"
else
  require_relative "binding/__callee__.rb"
  require_relative "binding/__method__.rb"
  require_relative "binding/call_stack.rb"
  require_relative "binding/caller.rb"
  require_relative "binding/callstack.rb"
  require_relative "binding/defined.rb"
  require_relative "binding/eval.rb"
  require_relative "binding/local_variables.rb"
  require_relative "binding/op.rb"
  require_relative "binding/self.rb"
end

=begin
require 'facets/binding/caller.rb'
require 'facets/binding/callstack.rb'
require 'facets/binding/call_stack.rb'
require 'facets/binding/defined.rb'
require 'facets/binding/eval.rb'
require 'facets/binding/local_variables.rb'
require 'facets/binding/op.rb'
require 'facets/binding/self.rb'
require 'facets/binding/__callee__.rb'
require 'facets/binding/__method__.rb'
=end
