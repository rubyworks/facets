class Matrix

  module Householder

    # a QR factorization that uses Householder transformation
    # Q^T * A = R
    # MC, Golub & van Loan, pg 224, 5.2.1 Householder QR

    def Householder.QR(mat)
      h = []
      a = mat.clone
      m = a.row_size
      n = a.column_size
      n.times{|j|
        v, beta = a[j..m - 1, j].house

        h[j] = Matrix.diag(Matrix.I(j), Matrix.I(m-j)- beta * (v * v.t))

        a[j..m-1, j..n-1] = (Matrix.I(m-j) - beta * (v * v.t)) * a[j..m-1, j..n-1]
        a[(j+1)..m-1,j] = v[2..(m-j)] if j < m - 1 }
      h
    end

    # From the essential part of Householder vector
    # it returns the coresponding upper(U_j)/lower(V_j) matrix

    def Householder.bidiagUV(essential, dim, beta)
      v = Vector.concat(Vector[1], essential)
      dimv = v.size
      Matrix.diag(Matrix.I(dim - dimv), Matrix.I(dimv) - beta * (v * v.t) )
    end

    # Householder Bidiagonalization algorithm. MC, Golub, pg 252, Algorithm 5.4.2
    # Returns the matrices U_B and V_B such that: U_B^T * A * V_B = B,
    # where B is upper bidiagonal.

    def Householder.bidiag(mat)
      a = mat.clone
      m = a.row_size
      n = a.column_size
      ub = Matrix.I(m)
      vb = Matrix.I(n)
      n.times{|j|
        v, beta = a[j..m-1,j].house
        a[j..m-1, j..n-1] = (Matrix.I(m-j) - beta * (v * v.t)) * a[j..m-1, j..n-1]
        a[j+1..m-1, j] = v[1..(m-j-1)]
        ub *= bidiagUV(a[j+1..m-1,j], m, beta) #Ub = U_1 * U_2 * ... * U_n
        if j < n - 2
          v, beta = (a[j, j+1..n-1]).house
          a[j..m-1, j+1..n-1] = a[j..m-1, j+1..n-1] * (Matrix.I(n-j-1) - beta * (v * v.t))
          a[j, j+2..n-1] = v[1..n-j-2]
          vb  *= bidiagUV(a[j, j+2..n-1], n, beta) #Vb = V_1 * U_2 * ... * V_n-2
        end  }
      return ub, vb
    end

    # Householder Reduction to Hessenberg Form

    def Householder.toHessenberg(mat)
      h = mat.clone
      n = h.row_size
      u0 = Matrix.I(n)
      for k in (0...n - 2)
        v, beta = h[k+1..n-1, k].house #the householder matrice part
        houseV = Matrix.I(n-k-1) - beta * (v * v.t)
        u0 *= Matrix.diag(Matrix.I(k+1), houseV)
        h[k+1..n-1, k..n-1] = houseV * h[k+1..n-1, k..n-1]
        h[0..n-1, k+1..n-1] = h[0..n-1, k+1..n-1] * houseV
      end
      return h, u0
    end

  end #end of Householder module

  # Returns the upper bidiagonal matrix obtained with Householder Bidiagonalization algorithm

  def bidiagonal
    ub, vb = Householder.bidiag(self)
    ub.t * self * vb
  end

  # Returns the orthogonal matrix Q of Householder QR factorization
  # where Q = H_1 * H_2 * H_3 * ... * H_n,

  def houseQ
    h = Householder.QR(self)
    q = h[0]
    (1...h.size).each{|i| q *= h[i]}
    q
  end

  # Returns the matrix R of Householder QR factorization
  # R = H_n * H_n-1 * ... * H_1 * A is an upper triangular matrix

  def houseR
    h = Householder.QR(self)
    r = self.clone
    h.size.times{|i| r = h[i] * r}
    r
  end

end

