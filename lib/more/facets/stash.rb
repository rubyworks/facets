require 'facets/hash/rekey'

# = Hash
#
# Stash is just like Hash, except that all keys are
# converted to Strings.
#
# This is rather fresh code, so is not yet complete.
# For instnace, it currently does not ensure that default
# keys are strings when using default_proc.
#
class Stash < Hash

  def fetch(k)
    super(k.to_s)
  end

  def store(k, v)
    super(k.to_s, v)
  end

  def has_key?(k)
    super(k.to_s)
  end

  def key?(k)
    super(k.to_s)
  end

  def [](k)
    super(k.to_s)
  end

  def []=(k,v)
    super(k.to_s, v)
  end

  def <<(other)
    cash other
    when Hash
      super(other.rekey(&:to_s))
    when Array
      self[other[0].to_s] = other[1]
    else
      raise ArgumentError
    end
  end

  def update(other)
    super(other.rekey(&:to_s))
  end

  def merge!(other)
    super(other.rekey(&:to_s))
  end
  
  def replace
    super(other.rekey(&:to_s))
  end

  def values_at(*keys)
    super(keys.map{|k|k.to_s})
  end

end

