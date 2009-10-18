# TITLE:
#
#   HashBuilder
#
# DESCRIPTION:
#
#   Build a hash programmatically via missing method calls.
#
# COPYRIGHT:
#
#   Copyright (c) 2006 Thomas Sawyer
#
# LICENSE:
#
#   Ruby License
#
#   This module is free software. You may use, modify, and/or redistribute this
#   software under the same terms as Ruby.
#
#   This program is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#   FOR A PARTICULAR PURPOSE.
#
# AUTHORS:
#
#   - Thomas Sawyer
#
# TODO:
#
#   - Use BuildingBlock ?


# = HashBuilder
#
# Build a hash programmatically via a fluent DSL-like syntax.
# In other words, this uses #method_missing to buld the hash.

class HashBuilder

  # Privatize a few Kernel methods that are most likely to clash,
  # but arn't essential here. TODO Maybe more in this context?

  alias :__class__ :class

  private *instance_methods.select{ |m| /^__/ !~ m.to_s }

  def self.load( blockstr, &block )
    new( blockstr, &block ).to_h
  end

  #def self.build( blockstr=nil, &block )
  #  self.new.build( blockstr, &block ).to_h
  #end

  def initialize( blockstr=nil, &block )
    @hash = {}
    @flag = {}
    build!( blockstr, &block )
  end

  def build!( blockstr=nil, &block )
    raise "both string and block given" if blockstr and block_given?
    if blockstr
      instance_eval blockstr
    else
      instance_eval &block
    end
    self  # or to_h ?
  end

  def to_h ; @hash ; end

  def method_missing( sym, *args, &block )
    sym = sym.to_s.downcase.chomp('=')

    if @hash.key?(sym)
      unless @flag[sym]
        @hash[sym] = [ @hash[sym] ]
        @flag[sym] = true
      end
      if block_given?
        @hash[sym] << self.__class__.new( &block ).to_h
      else
        @hash[sym] << args[0]
      end
    else
      if block_given?
        @hash[sym] = self.__class__.new( &block ).to_h
      else
        @hash[sym] = args[0]
      end
    end

  end

end


# Author::    Thomas Sawyer
# Copyright:: Copyright (c) 2006 Thomas Sawyer
# License::   Ruby License
