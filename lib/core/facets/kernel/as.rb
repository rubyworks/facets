require 'facets/functor'

module Kernel

  # Returns a As-functor that allows one to call any
  # ancestor's method directly of the given object.
  #
  #   class A
  #     def x ; 1 ; end
  #   end
  #
  #   class B < A
  #     def x ; 2 ; end
  #   end
  #
  #   class C < B
  #     def x ; as(A).x ; end
  #   end
  #
  #   C.new.x  #=> 1

  def as(ancestor, &blk)
    @__as ||= {}
    unless r = @__as[ancestor]
      r = (@__as[ancestor] = As.new(self, ancestor))
    end
    r.instance_eval(&blk) if block_given?
    #yield(r) if block_given?
    r
  end

  # Call parent class/module methods once bound to self.
  #
  # TODO: Does this have the proper scope for #send?

  def send_as(ancestor, sym, *args, &blk)
    ancestor.instance_method(sym).bind(self).call(*args,&blk)
  end

  #--
  #   def send_as(klass, meth, *args, &blk)
  #     selfclass = Kernel.instance_method(:class).bind(self).call
  #     raise ArgumentError if ! selfclass.ancestors.include?(klass)
  #     klass.instance_method(meth).bind(self).call(*args, &blk)
  #   end
  #++

  # Returns method of a parent class bound to self.

  def super_method(klass, meth)
    unless self.class.ancestors.include?(klass)
      raise ArgumentError, "Not an ancestor for super_method-- #{klass}"
    end
    klass.instance_method(meth).bind(self)
  end

  # Like super but skips to a specific ancestor module or class.
  #
  #   class A
  #     def x ; 1 ; end
  #   end
  #
  #   class B < A
  #     def x ; 2 ; end
  #   end
  #
  #   class C < B
  #     def x ; super_as(A) ; end
  #   end
  #
  #   C.new.x  #=> 1

  def super_as(klass=self.class.superclass, *args, &blk)
    unless self.class.ancestors.include?(klass)
      raise ArgumentError
    end
    called = /\`([^\']+)\'/.match(caller(1).first)[1].to_sym
    klass.instance_method(called).bind(self).call(*args,&blk)
  end

end

# Support class for Kernel#as.
#
# TODO: Deprecate this and use Functor (HigherOrderMessage) instead.

class As #:nodoc:
  # Privatize all methods except #binding an operators.
  private(*instance_methods.select { |m| m !~ /(^__|^\W|^binding$)/ })

  def initialize(subject, ancestor)
    @subject = subject
    @ancestor = ancestor
  end

  def method_missing(sym, *args, &blk)
    @ancestor.instance_method(sym).bind(@subject).call(*args,&blk)
  end
end

