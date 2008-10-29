# = CacheDecorator
#
# == Synopsis
#
# CacheDecorator wrap objects to provide cached versions of method calls.
#
#   class X
#     def initialize ; @tick = 0 ; end
#     def tick; @tick + 1; end
#     def cached; @cache ||= CacheDecorator.new(self) ; end
#   end
#
#   x = X.new
#   x.tick  #=> 1
#   x.cached.tick  #=> 2
#   x.tick  #=> 3
#   x.cached.tick  #=> 2
#   x.tick  #=> 4
#   x.cached.tick  #=> 2
#
# You can also use to cache a collections of objects to gain code
# speed ups.
#
#   points = points.collect{|point| Cache.cache(point)}
#
# After our algorithm has finished using points, we want to get rid of
# these Cache objects. That's easy:
#
#    points = points.collect{|point| point.self }
#
# Or if you prefer (it is ever so slightly safer):
#
#    points = points.collect{|point| Cache.uncache(point)}
#
# TODO: Is this a Memoizer? 
#       See http://javathink.blogspot.com/2008/09/what-is-memoizer-and-why-should-you.html
#
# == Authors
#
# * Erik Veenstra
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2006 Erik Veenstra
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

# = CacheDecorator
#
# CacheDecorator wrap objects to provide cached versions of method calls.
#
# == Usage
#
#   class X
#     def initialize ; @tick = 0 ; end
#     def tick; @tick + 1; end
#     def cached; @cache ||= CacheDecorator.new(self) ; end
#   end
#
#   x = X.new
#   x.tick  #=> 1
#   x.cached.tick  #=> 2
#   x.tick  #=> 3
#   x.cached.tick  #=> 2
#   x.tick  #=> 4
#   x.cached.tick  #=> 2
#
# You can also use to cache a collections of objects to gain code
# speed ups.
#
#   points = points.collect{|point| Cache.cache(point)}
#
# After our algorithm has finished using points, we want to get rid of
# these Cache objects. That's easy:
#
#    points = points.collect{|point| point.self }
#
# Or if you prefer (it is ever so slightly safer):
#
#    points = points.collect{|point| Cache.uncache(point)}
#
class CacheDecorator

  #private :class, :clone, :display, :type, :method, :to_a, :to_s
  private *instance_methods(true).select{ |m| m.to_s !~ /^__/ }

  def initialize(object)
    @self = object
    @cache = {}
  end

  def method_missing(method_name, *args, &block)
    # Not thread-safe! Speed is important in caches... ;]
    @cache[[method_name, args, block]] ||= @self.__send__(method_name, *args, &block)
  end

  def self; @self; end

  def self.cache(object)
    Cache.new(object)
  end

  def self.uncache(cached_object)
    cached_object.self
  end

end

# These are for backward compatibility (to be DEPRECATED)
Cache = CacheDecorator
CacheDelegator = Cache

