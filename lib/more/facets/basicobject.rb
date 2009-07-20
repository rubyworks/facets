# Facets' BasicObject is an implementation of Jim Weirich's BlankSlate.
#
# BlankSlate
# Copyright 2004 by Jim Weirich (jim@weirichhouse.org).
# All rights reserved.
#
# Since Ruby 1.9 has a BasicObject class this will of course be 
# deprecated as 1.9 goes mainstream.

unless defined? BasicObject  # just in case it already exists!

  # BasicObject provides an abstract base class with no predefined
  # methods (except for <tt>\_\_send__</tt> and <tt>\_\_id__</tt>).
  # BlankSlate is useful as a base class when writing classes that
  # depend upon <tt>method_missing</tt> (e.g. dynamic proxies).
  class BasicObject
    class << self

      # Hide the method named +name+ in the BlankSlate class.  Don't
      # hide +instance_eval+ or any method beginning with "__".
      def hide(name)
        undef_method name if
        instance_methods.include?(name.to_s) and
        name !~ /^(__|instance_eval)/
      end
    end

    instance_methods.each { |m| hide(m) }
  end


  # Since Ruby is very dynamic, methods added to the ancestors of
  # BlankSlate <em>after BlankSlate is defined</em> will show up in the
  # list of available BlankSlate methods.  We handle this by defining a
  # hook in the Object and Kernel classes that will hide any defined
  module Kernel #:nodoc:
    class << self
      alias_method :blank_slate_method_added, :method_added

      # Detect method additions to Kernel and remove them in the
      # BlankSlate class.
      def method_added(name)
        blank_slate_method_added(name)
        return if self != Kernel
        BlankSlate.hide(name)
      end
    end
  end

  class Object #:nodoc:
    class << self
      alias_method :blank_slate_method_added, :method_added

      # Detect method additions to Object and remove them in the
      # BlankSlate class.
      def method_added(name)
        blank_slate_method_added(name)
        return if self != Object
        BlankSlate.hide(name)
      end
    end
  end

end

unless defined? BlankSlate

  # ActiveSupport compatiable version of BasicObject
  # if not Ruby 1.9+ uses Jim Weirich's BlankSlate.
  BlankSlate = BasicObject

end

