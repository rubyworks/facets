# = opencascade.rb
#
# Copyright (c) 2006 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'facets/boolean' # bool
require 'facets/openobject'
#require 'facets/nullclass'

# = OpenCascade
#
# OpenCascade is subclass of OpenObject. It differs in a few
# significant ways.
#
# The main reason this class is labeled "cascade", every internal
# Hash is transformed into an OpenCascade dynamically upon access.
# This makes it easy to create "cascading" references.
#
#   h = { :x => { :y => { :z => 1 } } }
#   c = OpenCascade[h]
#   c.x.y.z  #=> 1
#
# As soon as you access a node it automatically becomes an OpenCascade.
#
#   c = OpenCascade.new   #=> #<OpenCascade:0x7fac3680ccf0 {}>
#   c.r                   #=> #<OpenCascade:0x7fac368084c0 {}>
#   c.a.b                 #=> #<OpenCascade:0x7fac3680a4f0 {}>
#
# But if you set a node, then that will be it's value.
#
#   c.a.b = 4             #=> 4
#
# To query a node without causing the auto-creation of an OpenCasade
# object, use the ?-mark.
#
#   c.a.z?                #=> nil
#
# Finally, you can set a node and get the reciever back using
# the !-mark.
#
#   c = OpenCascade.new   #=> #<OpenCascade:0x7fac3680ccf0 {}>
#   c.x!(4).y!(3)         #=> #<OpenCascade:0x7fac3680ccf0 {:x=>4, :y=>3}>
#
#--
# Last, when an entry is not found, 'null' is returned rather then 'nil'.
# This allows for run-on entries withuot error. Eg.
#
#   o = OpenCascade.new
#   o.a.b.c  #=> null
#
# Unfortuately this requires an explict test for of nil? in 'if' conditions,
#
#   if o.a.b.c.null?  # True if null
#   if o.a.b.c.nil?   # True if nil or null
#   if o.a.b.c.not?   # True if nil or null or false
#
# So be sure to take that into account.
#++

class OpenCascade < OpenObject

  def method_missing( sym, arg=nil )
    type = sym.to_s[-1,1]
    name = sym.to_s.gsub(/[=!?]$/, '').to_sym
    if type == '='
      self[name] = arg
    elsif type == '!'
      self[name] = arg
      self
    elsif type == '?'
      self[name]
    else
      if val = self[name]
        if Hash === val
          self[name] = self.class.new(val)
        else
          self[name]
        end
      else
        self[name] = self.class.new
      end
    end
  end

end

