require 'ostruct'

class OpenStruct

  # Access a value in the OpenStruct by key, like a Hash.
  # This increases OpenStruct's "duckiness".
  #
  #   o = OpenStruct.new
  #   o.t = 4
  #   o['t']  #=> 4
  #
  def [](key)
    key = key.to_sym unless key.is_a?(Symbol)
    @table[key]
  end

  # Set a value in the OpenStruct by key, like a Hash.
  #
  #   o = OpenStruct.new
  #   o['t'] = 4
  #   o.t  #=> 4
  #
  def []=(key,val)
    raise TypeError, "can't modify frozen #{self.class}", caller(1) if self.frozen?
    key = key.to_sym unless key.is_a?(Symbol)
    @table[key]=val
  end

end
