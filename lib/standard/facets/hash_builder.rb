# HashBuilder takes a procedure and builds a Hash out of it.
#
# The procedure must conform to a set of rules to be useful in this respect.
# They must either take an argument and use that argument to set values, or
# if no argument is taken then `#instance_eval` is used to evaluate the
# procedure such that each method represents a key.
#
class HashBuilder < BasicObject

  #
  def initialize(hash={}, &block)
    @hash = hash

    case block.arity
    when 0
      instance_eval(&block)
    else
      block.call(self)
    end
  end

  #
  def to_h
    @hash
  end

  #
  def method_missing(s, *a, &b)
    m = s.to_s
    if a.empty? && !b
      @hash[m.to_sym]
    else
      if b
        @hash[m.chomp('=').to_sym] = HashBuilder.new(&b).to_h
      else
        if a.size > 1
          @hash[m.chomp('=').to_sym] = a
        else
          @hash[m.chomp('=').to_sym] = a.first
        end
      end
    end
  end

end

