# Memoization is an optimization technique used primarily to speed up 
# programs by having function calls avoid repeating the calculation
# of results for previously-processed inputs.
#
# When you "memoize" a method/function using Memoizable its results are cached
# so that later calls return results from the cache instead of recalculating
# them.
#
#   class T
#     include Memoizable
#
#     def initialize(a)
#       @a = a
#     end
#
#     def a
#       "#{@a ^ 3 + 4}"
#     end
#
#     memoize :a
#   end
#
#   t = T.new
#   t.a.__id__ == t.a.__id__  #=> true
#
# This method can also be used at the instance level to cache singleton
# (qua class) methods by including it in the singleton class.
#
#--
# TODO: It would be very cool if Memoizable could set-up default parameters
# via #[] method, e.g. `include Memoizable[:freeze=>true]`.
#++

module Memoizable

  @cache = Hash.new{|h,k|h[k]=Hash.new{|h,k|h[k]={}}}

  #
  def self.cache
    @cache
  end

  #
  def self.append_features(base)
    Module == base ? super(base) :  base.extend(self)
  end

  # Directive for making your functions faster by trading space for time.
  # When you "memoize" a method/function using #memoize its results are
  # cached so that later calls with the same arguments return results from
  # the cache instead of recalculating them.
  #
  # The #memoize method also handles a few options to alter
  # behavior of the memoization:
  #
  #   :class     => true      cache per-class not per-object
  #   :freeze    => true      freeze the memoized return values
  #   :arguments => false     do not index cache by arguments
  #
  def memoize(*method_names)
    options = Hash === method_names.last ? method_names.pop : {}

    options[:arguments] = true if options[:arguments].nil?  # default to true

    ref = options[:class]     ? 'self.class.name'       : 'self'
    frz = options[:freeze]    ? '.freeze'               : ''
    arg = options[:arguments] ? '[__a__, block_given?]' : 'nil'

    code = ""
    method_names.each do |m|
      code << <<-code
        alias_method '#{ m }:memo', '#{ m }'
        private '#{ m }:memo'
        def #{ m }(*__a__,&__b__)
          c = Memoizable.cache[#{ref}][:'#{ m }']
          k = #{arg}
          if c.has_key?(k)
            c[k]
          else
            c[k] = __send__('#{ m }:memo',*__a__,&__b__)#{frz}
          end
        end
      code
    end
    module_eval(code)
  end

  # Remove the memoized value from the memoization cache.
  # The next time a memoized methos is called if will be
  # remomoized.
  def rememoize(*method_names)
    if Memoizable.cache[self]
      if method_names.empty?
        Memoizable.cache.delete(self)
      else
        method_names.each do |m|
          Memoizable.cache[self].delete(m.to_sym)
        end
      end
    end
    if Memoizable.cache[self.class.name]
      if method_names.empty?
        Memoizable.cache.delete(self.class.name)
      else
        method_names.each do |m|
          Memoizable.cache[self.class.name].delete(m.to_sym)
        end
      end
    end
  end

  #
  def unmemoize(*method_names)
    rememoize(*method_names)
    method_names.each do |m|
      alias_method name, "#{ m }:memo"
    end
  end

  # Include Memoizable alone with an #initialize_copy method that
  # will copy the memoization cache when #dup or #clone is used.
  #
  # TODO: Is this best approach? Perhaps a method to easily create
  # the #initialize_copy method would suffice?
  module Copy

    #
    def self.included(base)
      base.extend(Memoizable)
    end 

    #
    def initialize_copy(original)
      if Memoizable.cache.key?(original)
        Memoizable.cache[self] = Memoizable.cache[original].dup
      end
    end

  end

end
