# TITLE:
#
#   State
#
# SUMMARY:
#
#
#
# AUTHORS:
#
#   - Thomas Sawyer

# = State
#
class State < Hash

  #def initialize(object)
  #end

  def data_represents( klass )
    @data_represents = klass
  end

  def data_represents?( klass )
    @data_represents == klass
  end

  def to_object( klass=nil )
    #raise unless @data_represention
    obj = (klass||@data_represents).allocate
    obj.from_data( self )
    obj
  end

  def to_data
    dup
  end

  def from_data(state)
    replace(state)
  end
end

#
module Kernel

  # Create a hash representation of an object.

  def to_data( deep=false )
    #return self if Hash === self.class #object_class
    data = {}
    data.data_represents(self.class)
    instance_variables.each do |iv|
      name = iv[1..-1].to_sym  # removes @
      value = instance_variable_get(iv)
      value = value.to_data if deep
      data[name] = value
    end
    data
  end

  # Restore objects state from a hash representation of the object.

  def from_data(snap)
    #instance_variables.each { |iv| instance_variable_set(iv, snap[iv]) }
    snap.each { |iv, value| instance_variable_set("@#{iv}", value) }
    self
  end
end


class Array
  def to_data ; dup ; end
end

class String
  def to_data() dup end
  def from_data(snap) replace(snap) end
end

class Struct
  def to_data
    snap = Hash.new
    each_pair {|k,v| snap[k] = v}
    snap
  end

  def from_data(snap)
    snap.each_pair {|k,v| send(k.to_s + "=", v)}
  end
end


=begin test

  require 'test/unit'

  class TestToData < Test::Unit::TestCase

    class X
      attr_accessor :a, :b, :c
      def initialize(a, b, c)
        @a, @b, @c = a, b, c
      end
      def ==( other )
        return false if @a != other.a
        return false if @b != other.b
        return false if @c != other.c
        true
      end
    end

    def test_001
      x = X.new( 1, 2, 3 )
      assert_equal( { :a=>1, :b=>2, :c=>3 }, x.to_data )
    end

    def test_002
      x = X.new( 1, 2, [:a,:b] )
      assert_equal( { :a=>1, :b=>2, :c=>[:a,:b] }, x.to_data )
    end

    def test_003
      x = X.new( 1, 2, 3 )
      d = x.to_data
      x.a = 3
      assert_equal( 3, x.a )
      x.from_data(d)
      assert_equal( 1, x.a )
    end

    def test_004
      x = X.new( 1, 2, 3 )
      d = x.to_data
      y = d.to_object
      assert_equal( x, y )
    end

  end

=end
