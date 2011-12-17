# = Advisable
#
# Advisable provides a means of using before, after and
# around adivce in dynamic fashion.
#
module Advisable

  require 'facets/proc/bind'

  def self.append_features(base)
    base.extend(self)
  end

  def before(meth, &block)
    advice_before[meth.to_sym] << block
    method_added(meth) if method_defined?(meth)
  end

  def after(meth, &block)
    advice_after[meth.to_sym] << block
    method_added(meth) if method_defined?(meth)
  end

  def around(meth, &block)
    advice_around[meth.to_sym] << block
    method_added(meth) if method_defined?(meth)
  end

  def advice_before
    @advice_before ||= Hash.new{|h,k| h[k] = []}
  end

  def advice_after
    @advice_after ||= Hash.new{|h,k| h[k] = []}
  end

  def advice_around
    @advice_around ||= Hash.new{|h,k| h[k] = []}
  end

  # TODO: Should around advice be fed the result of the last around advice?
  def method_added(meth)
    @method_added_stack ||= []
    return if @method_added_stack.last == meth
    @method_added_stack << meth

    if advice_before.key?(meth) or advice_after.key?(meth)

      before = advice_before[meth]  || []
      around = advice_around[meth]  || []
      after  = advice_after[meth]   || []

      alias_method "#{meth}:advised", meth
      target = instance_method("#{meth}:advised")

      define_method meth do |*a, &b|
        before.reverse_each do |block|
          block.bind(self).call(*a,&b)
        end
        if around.empty?
          result = target.bind(self).call(*a,&b)
        else
          around.each do |block|
            result = block.call(target.bind(self),*a,&b)
          end
        end
        after.each do |block|
          block.bind(self).call(*a,&b)
        end
        result
      end
    end

    super(meth)

    @method_added_stack.pop
  end

end

