#--
# OpenStructable
#
# Copyright (c) 2005 Thomas Sawyer
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
# ==========================================================================
# Revision History ::
# --------------------------------------------------------------------------
# 05.04.28  Trans
#   - Minor modifications to documentation.
# ==========================================================================
#
# TODO
# Keep this uptodate with ostruct.rb.
#
# TODO Ask Matz
# See if Matz will accept it into core so we don't have to anymore.
#
# TODO Marshalling
# As with OpenStruct, marshalling is problematic at the moment.
#
#++

# OpensStructable is a mixin module which can provide OpenStruct behavior to
# any class or object. OpenStructable allows extention of data objects
# with arbitrary attributes.
#
# == Usage
#
#   require 'ostructable'
#
#   class Record
#     include OpenStructable
#   end
#
#   record = Record.new
#   record.name    = "John Smith"
#   record.age     = 70
#   record.pension = 300
#
#   puts record.name     # -> "John Smith"
#   puts record.address  # -> nil
#
# == Author(s)
#
# * Thomas Sawyer
# * Yukihiro Matsumoto
# * Gavin Sinclair (Documentation)
#
module OpenStructable

  def initialize(hash=nil)
    @__table__ = {}
    if hash
      for k,v in hash
        @__table__[k.to_sym] = v
        new_ostruct_member(k)
      end
    end
  end

  # duplicate an OpenStruct object members.
  def initialize_copy(orig)
    super
    @__table__ = @__table__.dup
  end

  def marshal_dump
    @table
  end
  def marshal_load(x)
    @table = x
    @table.each_key{|key| new_ostruct_member(key)}
  end

  def new_ostruct_member(name)
    unless self.respond_to?(name)
      self.instance_eval %{
        def #{name}; @__table__[:#{name}]; end
        def #{name}=(x); @__table__[:#{name}] = x; end
      }
    end
  end

  #
  # Generate additional attributes and values.
  #
  def update(hash)
    @__table__ ||= {}
    if hash
      for k,v in hash
        @__table__[k.to_sym] = v
        new_ostruct_member(k)
      end
    end
  end

  def method_missing(mid, *args) # :nodoc:
    mname = mid.to_s
    len = args.length
    if mname =~ /=$/
      if len != 1
        raise ArgumentError, "wrong number of arguments (#{len} for 1)", caller(1)
      end
      if self.frozen?
        raise TypeError, "can't modify frozen #{self.class}", caller(1)
      end
      mname.chop!
      @__table__ ||= {}
      @__table__[mname.intern] = args[0]
      self.new_ostruct_member(mname)
    elsif len == 0
      @__table__ ||= {}
      @__table__[mid]
    else
      raise NoMethodError, "undefined method `#{mname}' for #{self}", caller(1)
    end
  end

  #
  # Remove the named field from the object.
  #
  def delete_field(name)
    @__table__ ||= {}
    @__table__.delete name.to_sym
  end

  #
  # Returns a string containing a detailed summary of the keys and values.
  #
  def inspect
    str = "<#{self.class}"
    for k,v in (@__table__ ||= {})
      str << " #{k}=#{v.inspect}"
    end
    str << ">"
  end

  def __table__ # :nodoc:
    @__table__ ||= {}
  end
  protected :__table__

  # Compare this object and +other+ for equality.
  def ==(other)
    return false unless(other.kind_of?(OpenStruct))
    return @__table__ == other.table
  end

end

=begin
#
# It is possibe to implement OpenStruct itself with
# this OpenStructable module as follows:
#
class OpenStruct
  include OpenStructable
end
=end



#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#

=begin testing

  require 'test/unit'

  # fixture

  class Record
    include OpenStructable
  end

  # test

  class TC_OpenStructable < Test::Unit::TestCase

    def test_record
      record = nil
      assert_nothing_raised {
        record = Record.new
        record.name    = "John Smith"
        record.age     = 70
        record.pension = 300
      }
      assert_equal( "John Smith", record.name )
      assert_equal( 70, record.age )
      assert_equal( nil, record.address )
    end

  end

=end
