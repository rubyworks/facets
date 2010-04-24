# Facets' BasicObject is an implementation of Jim Weirich's BlankSlate.
#
# BlankSlate
# Copyright 2004 by Jim Weirich (jim@weirichhouse.org).
# All rights reserved.
#
# Since Ruby 1.9 has a BasicObject class this will of course be
# deprecated as 1.9 goes mainstream.

unless defined? BasicObject  # in case it already exists!

  # BasicObject provides an abstract base class with no predefined
  # methods (except for <tt>\_\_send__</tt> and <tt>\_\_id__</tt>).
  # BlankSlate is useful as a base class when writing classes that
  # depend upon <tt>method_missing</tt> (e.g. dynamic proxies).
  class BasicObject
    class << self
      # Hide the method named +name+ in the BlankSlate class.  Don't
      # hide +instance_eval+ or any method beginning with "__".
      #
      # According to 1.9.1 it should have only these methods:
      #
      # * #__send__
      # * #instance_eval
      # * #instance_exec
      # * #equal?
      # * #==
      # * #!
      # * #!=
      # * respond_to?
      #
      # Seems to me it should have #__id__ too.
      def hide(name)
        undef_method name if
          instance_methods.include?(name.to_s) and
          name !~ /^(__|respond_to\?|instance_eval$|instance_exec$|equal\?$|\=\=$)/
      end
    end
    instance_methods.each{ |m| hide(m) }
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
        BasicObject.hide(name)
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
        BasicObject.hide(name)
      end
    end
  end

end

