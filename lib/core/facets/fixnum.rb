class Fixnum
  n_bits = ([42].pack('L!').size * 8)

  MAX = 2 ** (n_bits - 2) - 1
  MIN = -MAX - 1
end

