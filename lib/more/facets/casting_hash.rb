# CastingHash is just like Hash, except that all keys and values
# are passed through casting procedures.
#--
# TODO: Handle default_proc.
#++
class CastingHash < Hash

  # Default key conversion procedure.
  KEY_PROC = lambda{ |x| x } #.to_s }

  # Default value conversion procedure.
  VAL_PROC = lambda{ |x| x }

  #
  def self.[](hash)
    s = new
    hash.each{ |k,v| s[k] = v }
    s
  end

  #
  def initialize(hash, value_cast=nil, &key_cast)
    @key_proc   = key_cast           || KEY_PROC
    @value_proc = value_cast.to_proc || VAL_PROC
    hash.each{ |k,v| self[k] = v }
  end

  #
  def key_proc
    @key_proc
  end

  #
  def key_proc=(proc)
    @key_proc = proc.to_proc
  end

  #
  def value_proc
    @value_proc
  end

  #
  def value_proc=(proc)
    @value_proc = proc.to_proc
  end

  #
  def [](k)
    super(key_proc[k])
  end

  #
  def []=(k,v)
    super(key_proc[k], value_proc[v])
  end

  #
  def <<(other)
    case other
    when Hash
      super(cast(other))
    when Array
      self[other[0]] = other[1]
    else
      raise ArgumentError
    end
  end

  def fetch(k)
    super(key_proc[k])
  end

  #
  def store(k, v)
    super(key_proc[k], value_proc[v])
  end

  #
  def key?(k)
    super(key_proc[k])
  end

  #
  def has_key?(k)
    super(key_proc[k])
  end

  # Synonym for Hash#rekey, but modifies the receiver in place (and returns it).
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }.to_stash
  #   foo.rekey!{ |k| k.upcase }  #=>  { "NAME"=>"Gavin", "WIFE"=>:Lisa }
  #   foo.inspect                 #=>  { "NAME"=>"Gavin", "WIFE"=>:Lisa }
  #
  def rekey!(*args, &block)
    # for backward comptability (DEPRECATE?).
    block = args.pop.to_sym.to_proc if args.size == 1
    if args.empty?
      block = lambda{|k| k} unless block
      keys.each do |k|
        nk = block[k]
        self[nk] = delete(k) #if nk
      end
    else
      raise ArgumentError, "3 for 2" if block
      to, from = *args
      self[to] = delete(from) if has_key?(from)
    end
    self
  end

  #
  def rekey(*args, &block)
    dup.rekey!(*args, &block)
  end

  #
  def delete(k)
    super(key_proc[k])
  end

  #
  def update(other)
    super(cast(other))
  end

  # Same as #update.
  def merge!(other)
    super(cast(other))
  end

  #
  def replace(other)
    super(cast(other))
  end

  #
  def values_at(*keys)
    super(keys.map(&key_proc))
  end

  #
  def to_hash
    h = {}; each{ |k,v| h[k] = v }; h
  end

  #
  alias_method :to_h, :to_hash

  private

    #
    def cast(hash)
      h
      hash.each do |k,v| 
        h[key_proc[k]] = value_proc[v]
      end
      h
    end

end


class Hash

  # Convert a Hash to a Stash object.
  def to_casting_hash(value_cast=nil, &key_cast)
    CastingHash.new(self, value_cast, &key_cast)
  end

end

