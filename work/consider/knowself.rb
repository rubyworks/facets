# Of course I'm not sure all of these are "real",
# but that's okay for now.

class Symbol
  def self.coercer ; :to_sym ; end
  def self.convertor ; :intern ; end
end

class Array
  def self.coercer ; :to_ary ; end
  def self.convertor ; :to_a ; end
end

class Hash
  def self.coercer ; :to_hash ; end 
  def self.convertor ; :to_h ; end
end

class String
  def self.coercer ; :to_str ; end
  def self.convertor ; :to_s ; end
end

class Range
  def self.coercer ; :to_rng ; end 
  def self.convertor ; :to_r ; end
end

class Regexp
  def self.coercer ; :to_rexp ; end 
  def self.convertor ; :to_re ; end
end

class Integer
  def self.coercer ; :to_int ; end 
  def self.convertor ; :to_i ; end
end

class Float
  def self.coercer ; :to_float ; end
  def self.convertor ; :to_f ; end
end
