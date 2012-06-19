# Memoizer wraps objects to provide cached method calls.
#
#   class X
#     def initialize ; @tick = 0 ; end
#     def tick; @tick + 1; end
#     def memo; @memo ||= Memoizer.new(self) ; end
#   end
#
#   x = X.new
#   x.tick       #=> 1
#   x.memo.tick  #=> 2
#   x.tick       #=> 3
#   x.memo.tick  #=> 2
#   x.tick       #=> 4
#   x.memo.tick  #=> 2
#
# You can also use to cache collections of objects to gain code speed ups.
#
#   points = points.collect{|point| Memoizer.cache(point)}
#
# After our algorithm has finished using points, we want to get rid of
# these Memoizer objects. That's easy:
#
#    points = points.collect{|point| point.__self__ }
#
# Or if you prefer (it is ever so slightly safer):
#
#    points = points.collect{|point| Memoizer.uncache(point)}
#
# Memoizer is the work of Erik Veenstra
#
# Copyright (c) 2006 Erik Veenstra
#
# See http://javathink.blogspot.com/2008/09/what-is-memoizer-and-why-should-you.html

class Memoizer

  #private :class, :clone, :display, :type, :method, :to_a, :to_s
  private *instance_methods(true).select{ |m| m.to_s !~ /^__/ }

  def initialize(object)
    @self  = object
    @cache = {}
  end

  def __self__ ; @self ; end

  # Not thread-safe! Speed is important in caches... ;]
  def method_missing(method_name, *args, &block)
    @cache[[method_name, args, block]] ||= @self.__send__(method_name, *args, &block)
  end

  #def self; @self; end

  def self.cache(object)
    new(object)
  end

  def self.uncache(cached_object)
    cached_object.instance_variable_get('@self')
  end

end
