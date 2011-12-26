class Matrix

  module LU

    #  Return the Gauss vector, MC, Golub, 3.2.1 Gauss Transformation, p94

    def LU.gauss_vector(mat, k)
      t = mat.column2matrix(k)
      tk = t[k, 0]
      (0..k).each{|i| t[i, 0] = 0}
      return t if tk == 0
      (k+1...mat.row_size).each{|i| t[i, 0] = t[i, 0].to_f / tk}
      t
    end

    # Return the Gauss transformation matrix: M_k = I - tau * e_k^T

    def LU.gauss(mat, k)
      i = Matrix.I(mat.column_size)
      tau = gauss_vector(mat, k)
      e = i.row2matrix(k)
      i - tau * e
    end

    # LU factorization: A = LU
    # where L is lower triangular and U is upper triangular

    def LU.factorization(mat)
      u = mat.clone
      n = u.column_size
      i = Matrix.I(n)
      l = i.clone
      (n-1).times {|k|
        mk = gauss(u, k)
        u = mk * u  # M_{n-1} * ... * M_1 * A = U
        l += i - mk  # L = M_1^{-1} * ... * M_{n-1}^{-1} = I + sum_{k=1}^{n-1} tau * e
      }
      return l, u
    end
  end

  # Return the upper triangular matrix of LU factorization
  # M_{n-1} * ... * M_1 * A = U

  def U
    LU.factorization(self)[1]
  end

  # Return the lower triangular matrix of LU factorization
  # L = M_1^{-1} * ... * M_{n-1}^{-1} = I + sum_{k=1}^{n-1} tau * e

  def L
    LU.factorization(self)[0]
  end

end

