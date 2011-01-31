require 'facets/functor'

module Kernel

  # Returns a As-functor that allows one to call any
  # ancestor's method directly of the given object.
  #
  #   class AsExample1
  #     def x ; 1 ; end
  #   end
  #
  #   class AsExample2 < AsExample1
  #     def x ; 2 ; end
  #   end
  #
  #   class AsExample3 < AsExample2
  #     def x ; as(AsExample1).x ; end
  #   end
  #
  #   AsExample1.new.x  #=> 1
  #
  def as(ancestor, &blk)
    ##this = self
    r = As.new(self, ancestor)
    ##unless r
    ##  r = As.cache[self][ancestor] = Functor.new do |op, *a, &b|
    ##    ancestor.instance_method(op).bind(this).call(*a,&b)
    ##  end
    ##end
    r.instance_eval(&blk) if block_given? #yield(r) if block_given?
    r
  end

  # Call parent class/module methods once bound to self.
  #
  # TODO: Does this have the proper scope for #send?
  def send_as(ancestor, sym, *args, &blk)
    ancestor.instance_method(sym).bind(self).call(*args,&blk)
  end

  #--
  # Old version ...
  #
  #   def send_as(klass, meth, *args, &blk)
  #     selfclass = Kernel.instance_method(:class).bind(self).call
  #     raise ArgumentError if ! selfclass.ancestors.include?(klass)
  #     klass.instance_method(meth).bind(self).call(*args, &blk)
  #   end
  #++

  ## DEPRECATED: There's no reliable way to get method name of caller.
  ## This needs to have the same knowledge that #super itself has and
  ## I do not thin that is possbile in pure Ruby.
  ##
  ## Like super but skips to a specific ancestor module or class.
  ##
  ##   class SuperAsExample1
  ##     def x ; 1 ; end
  ##   end
  ##
  ##   class SuperAsExample2 < SuperAsExample1
  ##     def x ; 2 ; end
  ##   end
  ##
  ##   class SuperAsExample3 < SuperAsExample2
  ##     def x ; super_as(SuperAsExample1) ; end
  ##   end
  ##
  ##   SuperAsExample3.new.x  #=> 1
  ##
  ##def super_as(klass=self.class.superclass, *args, &blk)
  ##  unless self.class.ancestors.include?(klass)
  ##    raise ArgumentError
  ##  end
  ##  #called = /\`([^\']+)\'/.match(caller(1).first)[1].to_sym
  ##  called = File.basename(caller(1).first)
  ##  klass.instance_method(called).bind(self).call(*args,&blk)
  ##end
end

# Support class for Kernel#as.
#
# TODO: Deprecate this and use Functor (HigherOrderMessage) instead ?

class As #:nodoc:
 
  class << self
    alias_method :_new, :new

    def new(subject, ancestor)
      cache[subject][ancestor] ||= _new(subject, ancestor)
    end
    
    def cache
      @cache ||= Hash.new{|h,k| h[k]={} }
    end

    private :_new
    private :cache
  end

  # Privatize all methods except #binding an operators.
  private(*instance_methods.select { |m| m !~ /(^__|^\W|^binding$)/ })

  def initialize(subject, ancestor)
    @subject = subject
    @ancestor = ancestor
  end

  private
  def method_missing(sym, *args, &blk)
    @ancestor.instance_method(sym).bind(@subject).call(*args,&blk)
  end
end

