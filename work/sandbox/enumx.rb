# = FILE
#
#   elementwise.rb
#
# = DESCRIPTION
#
#   Elementwise extensions to Enumerable.
#
# = AUTHORS
#
#   CREDIT Martin DeMello
#   CREDIT Sean O'Halpin
#
# = NOTES
#
#   NOTE Deprecated #~@ alias for elementwise.

require 'enumerator'

class Enumerable::Enumerator
  alias init initialize

  def initialize(*args)
    @enum_obj, @enum_meth = *args
    @enum_meth ||= :each
    init(*args)
  end

  def method_missing(sym,*args,&blk)
    each{ |x| x.send(sym,*args,&blk) }
  end
end

class Enumerable::Elementor < Enumerable::Enumerator
  def method_missing(sym,*args,&blk)
    each{ |x| x.send(sym,*args,&blk) }.to_elem(@enum_meth)
  end
end

#
module Enumerable

  def to_elem(op)
    Enumerable::Elementor.new(self,op)
  end

  ops = %w{map select reject detect find collect}

  ops.each do |op|
    module_eval %{
      alias _#{op} #{op}

      def #{op}(&b)
        if block_given?
          _#{op}(&b)
        else
          to_enum(:#{op})
        end
      end

      def #{op}x(&b)
        if block_given?
          #{op}(&b)
        else
          to_elem(:#{op})
        end
      end
    }
  end

end

class Array

  ENUM_METHODS = {}

  ["map", "reject", "collect", "select"].each{ |m|
    ENUM_METHODS[m.to_sym] = instance_method(m)
  }

  ENUM_METHODS.keys.each do |op|
    module_eval %{
      def #{op}(&b)
        if block_given?
          ENUM_METHODS[:#{op}].bind(self).call(&b)
        else
          to_enum(:#{op})
        end
      end

      def #{op}x(&b)
        if block_given?
          ENUM_METHODS[:#{op}].bind(self).call(&b)
        else
          to_elem(:#{op})
        end
      end
    }
   end
end

#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test

  require 'test/unit'

  class TestElemental < Test::Unit::TestCase

  end

=end
