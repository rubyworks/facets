module Kernel #:nodoc:

  # Directive for making your functions faster by trading
  # space for time. When you "memoize" a method/function
  # using #once its results are cached so that later calls
  # with the same arguments return results from the cache
  # instead of recalculating them.
  #
  #   class T
  #     def initialize(a)
  #       @a = a
  #     end
  #     def a
  #       "#{@a ^ 3 + 4}"
  #     end
  #     once :a
  #   end
  #
  #   t = T.new
  #   t.a.__id__ == t.a.__id__  #=> true
  #
  # This methis can also be used at the instance level
  # to cache singleton/eigen methods.
  #
  # CREDIT Robert Feldt
  #
  def once(*ids)
    if ids.empty?
      @once ||= Hash::new{|h,k| h[k]={}}
    else
      base = (Module === self ? self : (class << self; self; end))
      ids.each do |m|
        base.module_eval <<-code
          alias_method '#{ m }:once', '#{ m }'
          def #{ m }(*__a__,&__b__)
            c = once['#{ m }']
            k = [__a__,__b__]
            if c.has_key? k
              c[k]
            else
              c[k] = __send__('#{ m }:once',*__a__,&__b__)
            end
          end
        code
      end
    end
  end

  # +once+ is also widely known as +memoize+.
  alias_method :memoize, :once
  alias_method :cache, :once

end

