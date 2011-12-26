class Matrix

  module Jacobi

    # Returns the nurm of the off-diagonal element

    def Jacobi.off(a)
      n = a.row_size
      sum = 0
      n.times{|i| n.times{|j| sum += a[i, j]**2 if j != i}}
      Math.sqrt(sum)
    end

    # Returns the index pair (p, q) with 1<= p < q <= n and A[p, q] is the maximum in absolute value

    def Jacobi.max(a)
      n = a.row_size
      max = 0
      p = 0
      q = 0
      n.times{|i|
        ((i+1)...n).each{|j|
          val = a[i, j].abs
          if val > max
            max = val
            p = i
            q = j
          end  }}
      return p, q
    end

    # Compute the cosine-sine pair (c, s) for the element A[p, q]

    def Jacobi.sym_schur2(a, p, q)
      if a[p, q] != 0
        tau = Float(a[q, q] - a[p, p])/(2 * a[p, q])
        if tau >= 0
          t = 1./(tau + Math.sqrt(1 + tau ** 2))
        else
          t = -1./(-tau + Math.sqrt(1 + tau ** 2))
        end
        c = 1./Math.sqrt(1 + t ** 2)
        s = t * c
      else
        c = 1
        s = 0
      end
      return c, s
    end

    # Returns the Jacobi rotation matrix

    def Jacobi.J(p, q, c, s, n)
      j = Matrix.I(n)
      j[p,p] = c; j[p, q] = s
      j[q,p] = -s; j[q, q] = c
      j
    end

  end

  # Classical Jacobi 8.4.3 Golub & van Loan

  def cJacobi(tol = 1.0e-10)
    a = self.clone
    n = row_size
    v = Matrix.I(n)
    eps = tol * a.normF
    while Jacobi.off(a) > eps
      p, q = Jacobi.max(a)
      c, s = Jacobi.sym_schur2(a, p, q)
      #print "\np:#{p} q:#{q} c:#{c} s:#{s}\n"
      j = Jacobi.J(p, q, c, s, n)
      a = j.t * a * j
      v = v * j
    end
    return a, v
  end

  # Returns the aproximation matrix computed with Classical Jacobi algorithm.
  # The aproximate eigenvalues values are in the diagonal of the matrix A.

  def cJacobiA(tol = 1.0e-10)
    cJacobi(tol)[0]
  end

  # Returns a Vector with the eigenvalues aproximated values.
  # The eigenvalues are computed with the Classic Jacobi Algorithm.

  def eigenvaluesJacobi
    a = cJacobiA
    Vector[*(0...row_size).collect{|i| a[i, i]}]
  end

  # Returns the orthogonal matrix obtained with the Jacobi eigenvalue algorithm.
  # The columns of V are the eigenvector.

  def cJacobiV(tol = 1.0e-10)
    cJacobi(tol)[1]
  end

end

