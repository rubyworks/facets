# = TITLE:
#   Vector
#
# = SYNOPSIS:
#   An implementation of the Vector class.
#
# = AUTHORS:
#   - Keiju ISHITSUKA
#   - Cosmin Bonchis
#
# = DOCUMENTORS:
#   - Gavin Sinclair
#
# = NOTES:
#   - Original Version from Smalltalk-80 version.
#   - Extensions from Google Summer of Code 2007 project for Ruby Central Inc.

#
class Vector

  include Enumerable

  module Norm
    def Norm.sqnorm(obj, p)
      sum = 0
      obj.each{|x| sum += x ** p}
      sum
    end
  end

  alias :length :size

  alias :index :[]

  # Returns the value of an index vector or
  # a Vector with the values of a range.
  # 
  #   v = Vector[1, 2, 3, 4]
  #   v[0] => 1
  #   v[0..2] => Vector[1, 2, 3]
  #
  def [](i)
    case i
    when Range
      Vector[*to_a.slice(i)]
    else
      index(i)
    end
  end

  # Sets a vector value/(range of values) with a new value/(values from a vector)
  # v = Vector[1, 2, 3]
  # v[2] = 9 => Vector[1, 2, 9]
  # v[1..2] = Vector[9, 9, 9, 9, 9] => v: Vector[1, 9, 9]
  #
  def []=(i, v)
    case i
    when Range
      (self.size..i.begin - 1).each{|e| self[e] = 0} # self.size must be in the first place because the size of self can be modified
      [v.size, i.entries.size].min.times {|e| self[e + i.begin] = v[e]}
      (v.size + i.begin .. i.end).each {|e| self[e] = 0}
    else
      @elements[i]=v
    end
  end

  class << self

    # Returns a concatenated Vector
    #
    def concat(*args)
      v = []
      args.each{|x| v += x.to_a}
      Vector[*v]
    end
  end

  # Changes the elements of vector and returns a Vector
  #
  def collect!
    els = @elements.collect! {|v| yield(v)}
    Vector.elements(els, false)
  end

  # Iterates the elements of a vector
  #
  def each
    (0...size).each {|i| yield(self[i])}
    nil
  end

  # Returns the maximum element of a vector
  #
  def max
    to_a.max
  end

  # Returns the minimum element of a vector
  #
  def min
    to_a.min
  end

  # Returns the p-norm of a vector
  #
  def norm(p = 2)
    Norm.sqnorm(self, p) ** (Float(1)/p)
  end

  # Returns the infinite-norm
  #
  def norm_inf
    [min.abs, max.abs].max
  end

  # Returns a slice of vector
  #
  def slice(*args)
    Vector[*to_a.slice(*args)]
  end

  #
  def slice_set(v, b, e)
    for i in b..e
      self[i] = v[i-b]
    end
  end

  # Sets a slice of vector
  #
  def slice=(args)
    case args[1]
    when Range
      slice_set(args[0], args[1].begin, args[1].last)
    else
      slice_set(args[0], args[1], args[2])
    end
  end

  # Return the vector divided by a scalar
  #
  def /(c)
    map {|e| e.quo(c)}
  end

  #
  # Return the matrix column coresponding to the vector transpose
  #
  def transpose
    Matrix[self.to_a]
  end

  alias :t :transpose

  #
  # Computes the Householder vector (MC, Golub, p. 210, algorithm 5.1.1)
  #
  def house
    s = self[1..length-1]
    sigma = s.inner_product(s)
    v = clone; v[0] = 1
    if sigma == 0
      beta = 0
    else
      mu = Math.sqrt(self[0] ** 2 + sigma)
      if self[0] <= 0
        v[0] = self[0] - mu
      else
        v[0] = - sigma.quo(self[0] + mu)
      end
      v2 = v[0] ** 2
      beta = 2 * v2.quo(sigma + v2)
      v /= v[0]
    end
    return v, beta
  end

  # Projection operator
  #
  # http://en.wikipedia.org/wiki/Gram-Schmidt_process#The_Gram.E2.80.93Schmidt_process
  #
  def proj(v)
    vp = v.inner_product(self)
    vp = Float vp if vp.is_a?(Integer)
    self * (vp / inner_product(self))
  end

  # Return the vector normalized
  #
  def normalize
    self / self.norm
  end

  # Stabilized Gram-Schmidt process
  #
  # (http://en.wikipedia.org/wiki/Gram-Schmidt_process#Algorithm)
  #
  def Vector.gram_schmidt(*vectors)
    v = vectors.clone
    for j in 0...v.size
      for i in 0..j-1
        v[j] -= v[i] * v[j].inner_product(v[i])
      end
      v[j] /= v[j].norm
    end
    v
  end

end

