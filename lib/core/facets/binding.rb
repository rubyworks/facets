=begin :till+11:
<%=
  path = __FILE__.chomp('.rb')
  base = File.basename(path)
  Dir[File.join(path, '*.rb')].map do |lib|
    %Q{require "facets/#{base}/#{File.basename(lib)}"}
  end.sort.join("\n")
%>
=end
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

