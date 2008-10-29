# = Reflection
#
# Provides externailzed, safe access to an object's meta-information.
#
# == Authors
#
# * Thomas Sawyer
#
# == Copying
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
#
# == NOTES
#
# This is expirmental. Maybe it should be moved to the Trinkets project.
# The idea is to be able to access a object as a pure object, by binding
# methods called to Object/Kernel first. Thus bypassing any overriden
# methods.
#
# But you can use #at to do this already.
#
#   obj.at(Object).object_id
#
# For metaprogramming this can be important.

#
class << ObjectSpace
  alias_method :[], :_id2ref
end

# = ObjectReflection
#
#   obj.__object__.id
#   obj.__object__.class
#
# NOTE: This is still an expirmental library.

class ObjectReflection

  instance_methods.each{|m| private(m) unless m.to_s =~ /^__/ }

  #
  def initialize(object)
    @self = object
    @meth = {}
  end

  #
  def id
    _bind_method(:object_id).call
  end

  #Kernel.instance_methods.select{ |m| m =~ /^instance_/ }.each do |m|
  #  meth = m.to_s.sub(/^instance_/, '')
  #  module_eval %{
  #    def #{meth}(*a, &b)
  #      _bind_method(:#{m}).call(*a,&b)
  #    end
  #  }
  #end

  def method_missing(s, *a, &b)
    _bind_method(s).call(*a, &b)
  end

  private

  def _bind_method(meth)
    @meth[meth.to_sym] ||= Kernel.instance_method(meth).bind(@self)
  end

end

module Kernel

  # Binds a method to Object/Kernel before calling it.
  #
  #   obj.__object__.id
  #   obj.__object__.class
  #
  # For metaprogramming this can be important.

  def __object__
    @_object_reflection ||= ObjectReflection.new(self)
  end

  #def __instance__
  #  @_instance_reflection ||= InstanceReflection.new(self)
  #end

end



=begin
# = InstanceReflection
#
#   obj.__instance__.id
#   obj.__instance__.class
#
#
class InstanceReflection < ObjectReflection

  REFLECTION_METHODS = (
    meths = Kernel.instance_methods.select{ |m| m =~ /^instance_/ }
    meths += [:send]
    meths.collect!{|m| m.to_sym}
    meths.uniq!
p meths
    meths
  )

  def initialize(object)
    @self = object
    @proc = {}
    #@meta = REFLECTION_METHODS.inject({}) do |rproc, meth|
    #  name = meth.to_s.sub(/^instance_/, '').to_sym
    #  rproc[name] = Kernel.instance_method(meth).bind(@self)
    #  rproc
    #end
  end

  REFLECTION_METHODS.each do |meth|
    name = meth.to_s.sub(/^instance_/, '')

    module_eval %{
      def #{name}(*a,&b)
        @proc[:#{meth}] ||= Kernel.instance_method(:#{meth}).bind(@self)
        @proc[:#{meth}].call(*a,&b)
      end
    }, __FILE__, __LINE__
  end

end
=end

