class Matrix

  module Givens

    # Returns the values "c and s" of a Given rotation
    # MC, Golub, pg 216, Alghorithm 5.1.3

    def Givens.givens(a, b)
      if b == 0
        c = 0; s = 0
      else
        if b.abs > a.abs
          tau = Float(-a)/b; s = 1/Math.sqrt(1+tau**2); c = s * tau
        else
          tau = Float(-b)/a; c = 1/Math.sqrt(1+tau**2); s = c * tau
        end
      end
      return c, s
    end

    # a QR factorization using Givens rotation
    # Computes the upper triangular matrix R and the orthogonal matrix Q
    # where Q^t A = R (MC, Golub, p227 algorithm 5.2.2)

    def Givens.QR(mat)
      r = mat.clone
      m = r.row_size
      n = r.column_size
      q = Matrix.I(m)
      n.times{|j|
        m-1.downto(j+1){|i|
          c, s = givens(r[i - 1, j], r[i, j])
          qt = Matrix.I(m); qt[i-1..i, i-1..i] = Matrix[[c, s],[-s, c]]
          q *= qt
          r[i-1..i, j..n-1] = Matrix[[c, -s],[s, c]] * r[i-1..i, j..n-1]}}
      return r, q
    end

  end

  # Returns the upper triunghiular matrix R of a Givens QR factorization

  def givensR
    Givens.QR(self)[0]
  end

  # Returns the orthogonal matrix Q of Givens QR factorization.
  # Q = G_1 * ... * G_t where G_j is the j'th Givens rotation
  # and 't' is the total number of rotations

  def givensQ
    Givens.QR(self)[1]
  end

end

