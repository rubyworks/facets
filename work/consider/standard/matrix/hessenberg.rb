require 'euclid/matrix/householder'

class Matrix

  module Hessenberg

    #  The matrix must be an upper R^(n x n) Hessenberg matrix

    def Hessenberg.QR(mat)
      r = mat.clone
      n = r.row_size
      q = Matrix.I(n)
      for j in (0...n-1)
        c, s = Givens.givens(r[j,j], r[j+1, j])
        cs = Matrix[[c, s], [-s, c]]
        q *= Matrix.diag(Matrix.I(j), cs, Matrix.I(n - j - 2))
        r[j..j+1, j..n-1] = cs.t * r[j..j+1, j..n-1]
      end
      return q, r
    end
  end

  # Returns the orthogonal matrix Q of Hessenberg QR factorization
  # Q = G_1 *...* G_(n-1) where G_j is the Givens rotation G_j = G(j, j+1, omega_j)

  def hessenbergQ
    Hessenberg.QR(self)[0]
  end

  # Returns the upper triunghiular matrix R of a Hessenberg QR factorization

  def hessenbergR
    Hessenberg.QR(self)[1]
  end

  # Return an upper Hessenberg matrix obtained with Householder reduction to Hessenberg Form algorithm

  def hessenberg_form_H
    Householder.toHessenberg(self)[0]
  end

  # The real Schur decomposition.
  # The eigenvalues are aproximated in diagonal elements of the real Schur decomposition matrix

  def realSchur(eps = 1.0e-10, steps = 100)
    h = self.hessenberg_form_H
    h1 = Matrix[]
    i = 0
    loop do
      h1 = h.hessenbergR * h.hessenbergQ
      break if Matrix.diag_in_delta?(h1, h, eps) or steps <= 0
      h = h1.clone
      steps -= 1
      i += 1
    end
    h1
  end

end

