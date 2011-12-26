require 'rational'
require 'matrix'
require 'mapcar'

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
	#
	#	Returns the value of an index vector or
	#	a Vector with the values of a range
	# v = Vector[1, 2, 3, 4]
	#	v[0] => 1
	#	v[0..2] => Vector[1, 2, 3]
	#
	def [](i)
		case i
		when Range
			Vector[*to_a.slice(i)]
		else
			index(i)
		end	
	end

	#
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
		#
		# Returns a concatenated Vector
		#
		def concat(*args)
			v = []
			args.each{|x| v += x.to_a}
			Vector[*v]
		end
	end

	#
	# Changes the elements of vector and returns a Vector
	#
	def collect! 
		els = @elements.collect! {|v| yield(v)}
		Vector.elements(els, false)
	end

	#
	# Iterates the elements of a vector
	#
	def each 
		(0...size).each {|i| yield(self[i])}
		nil
	end

	#
	# Returns the maximum element of a vector
	#
	def max
		to_a.max
	end
  
	#
	# Returns the minimum element of a vector
	#
  def min
    to_a.min
  end

	#
	# Returns the p-norm of a vector
	#
	def norm(p = 2)
    Norm.sqnorm(self, p) ** (Float(1)/p)
  end

  #
	# Returns the infinite-norm 
	#
  def norm_inf
    [min.abs, max.abs].max
  end
	
	#
	# Returns a slice of vector
	#
	def slice(*args)
		Vector[*to_a.slice(*args)]	
	end

	def slice_set(v, b, e)
		for i in b..e
			self[i] = v[i-b]	
		end
	end

	#
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

	#
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

	#
	#Projection operator 
	#(http://en.wikipedia.org/wiki/Gram-Schmidt_process#The_Gram.E2.80.93Schmidt_process)
	#
	def proj(v)
		vp = v.inner_product(self)
		vp = Float vp if vp.is_a?(Integer)
		self * (vp / inner_product(self))
	end

	#
	# Return the vector normalized
	#
	def normalize
		self / self.norm
	end

	# 
	# Stabilized Gram-Schmidt process 
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

class Matrix
	include Enumerable
	public_class_method :new

  attr_reader :rows, :wrap
	@wrap = nil
	
	def initialize(*argv)
		return initialize_old(*argv) if argv[0].is_a?(Symbol)
		n, m, val = argv; val = 0 if not val
		f = (block_given?)? lambda {|i,j| yield(i, j)} : lambda {|i,j| val}
		init_rows((0...n).collect {|i| (0...m).collect {|j| f.call(i,j)}}, true)
	end

	#
	# For invoking a method  
	# in Ruby1.8 is working 'send' and
	# in Ruby1.9 is working 'funcall'
	#
	def initialize_old(init_method, *argv)
		if RUBY_VERSION < "1.9.0"
			self.send(init_method, *argv) # in Ruby1.8
		else
			self.funcall(init_method, *argv) # in Ruby1.9
		end
	end

	alias :ids :[]
	#
	# Return a value or a vector/matrix of values depending 
	# if the indexes are ranges or not
	# m = Matrix.new(4, 3){|i, j| i * 3 + j}
	# m: 0  1  2
	#    3  4  5
	#    6  7  8
	#    9 10 11
	# m[1, 2] => 5
	# m[3,1..2] => Vector[10, 11]
	# m[0..1, 0..2] => Matrix[[0, 1, 2], [3, 4, 5]]
	#
	def [](i, j)
		case i
		when Range 
			case j
			when Range
				Matrix[*i.collect{|l| self.row(l)[j].to_a}]
			else
				column(j)[i]	
			end
		else
			case j
			when Range
				row(i)[j]
			else
				ids(i, j)
			end
		end		
	end

	#
	# Set the values of a matrix
	# m = Matrix.new(3, 3){|i, j| i * 3 + j}
	# m: 0  1  2
	#    3  4  5
	#    6  7  8
	# m[1, 2] = 9 => Matrix[[0, 1, 2], [3, 4, 9], [6, 7, 8]]
	# m[2,1..2] = Vector[8, 8] => Matrix[[0, 1, 2], [3, 8, 8], [6, 7, 8]]
	# m[0..1, 0..1] = Matrix[[0, 0, 0],[0, 0, 0]] 
	# 		=> Matrix[[0, 0, 2], [0, 0, 8], [6, 7, 8]]
	#
	def []=(i, j, v)
		case i
		when Range
			if i.entries.size == 1
				self[i.begin, j] = (v.is_a?(Matrix) ? v.row(0) : v)
			else
				case j
				when Range
					if j.entries.size == 1
						self[i, j.begin] = (v.is_a?(Matrix) ? v.column(0) : v)
					else
						i.each{|l| self.row= l, v.row(l - i.begin), j}
					end
				else
					self.column= j, v, i	
				end
			end
		else
			case j
			when Range
				if j.entries.size == 1
					self[i, j.begin] = (v.is_a?(Vector) ? v[0] : v)
				else
					self.row= i, v, j
				end
			else
				@rows[i][j] = (v.is_a?(Vector) ? v[0] : v)

			end
		end		
	end	

	#
	# Return a clone matrix
	#
	def clone
		super
	end

	def initialize_copy(orig)
		init_rows(orig.rows, true)
		self.wrap=(orig.wrap)
	end


	class << self
		#
		# Creates a matrix with the given matrices as diagonal blocks
		#
		def diag(*args)
			dsize = 0
			sizes = args.collect{|e| x = (e.is_a?(Matrix)) ? e.row_size : 1; dsize += x; x}
			m = Matrix.zero(dsize)
			count = 0

			sizes.size.times{|i| 
				range = count..(count+sizes[i]-1)
				m[range, range] = args[i]
				count += sizes[i]
			}
			m
		end

		#
		# Tests if all the elements of two matrix are equal in delta
		#
		def equal_in_delta?(m0, m1, delta = 1.0e-10)
			delta = delta.abs
			mapcar(m0, m1){|x, y| return false if (x < y - delta or x > y + delta)  }
			true
		end

		#
		# Tests if all the diagonal elements of two matrix are equal in delta
		#
		def diag_in_delta?(m1, m0, eps = 1.0e-10)
			n = m1.row_size
			return false if n != m0.row_size or m1.column_size != m0.column_size
			n.times{|i|
				return false if (m1[i,i]-m0[i,i]).abs > eps
			}
			true
		end
	end

	#
	# Returns the matrix divided by a scalar
	#
	def quo(v)
		map {|e| e.quo(v)}
	end

	#
	# quo seems always desirable
	#
	alias :/ :quo

	#
	# Set de values of a matrix and the value of wrap property
	#
	def set(m)
		0.upto(m.row_size - 1) do |i|
			0.upto(m.column_size - 1) do |j|
				self[i, j] = m[i, j]
			end
		end
		self.wrap = m.wrap
	end

	def wraplate(ijwrap = "")
		 "class << self
			  def [](i, j)
			    #{ijwrap}; @rows[i][j]
		    end

		    def []=(i, j, v)
		      #{ijwrap}; @rows[i][j] = v
		    end
		  end"
	end

	#
	# Set wrap feature of a matrix
	#
	def wrap=(mode = :torus)
		case mode
		when :torus then eval(wraplate("i %= row_size; j %= column_size"))
		when :h_cylinder then eval(wraplate("i %= row_size"))
		when :v_cylinder then eval(wraplate("j %= column_size"))
		when :nil then eval(wraplate)
		end
		@wrap = mode
	end
	
	#
	# Returns the maximum length of column elements
	#
	def max_len_column(j)		
		column_collect(j) {|x| x.to_s.length}.max
	end
	
	#
	# Returns a list with the maximum lengths
	#
	def cols_len
		(0...column_size).collect {|j| max_len_column(j)}
	end
	
	#
	# Returns a string for nice printing matrix
	#
	def to_s(mode = :pretty, len_col = 3)
		return super if empty?
		if mode == :pretty
			clen = cols_len
			to_a.collect {|r| mapcar(r, clen) {|x, l| format("%#{l}s ",x.to_s)} << "\n"}.join("")
		else
			i = 0; s = ""; cs = column_size
			each do |e|
				i = (i + 1) % cs
				s += format("%#{len_col}s ", e.to_s)
				s += "\n" if i == 0
			end
			s
		end
	end

	#
	# Iterate the elements of a matrix
	#
	def each
		@rows.each {|x| x.each {|e| yield(e)}}
		nil
	end

	#
	# a hided module of Matrix
	module MMatrix
		def MMatrix.default_block(block)
    	block ? lambda { |i| block.call(i) } : lambda {|i| i }
  	end

		#
		# Returns: 
		# 1) the index of row/column and 
		# 2) the values Vector for changing the row/column and 
		# 3) the range of changes
		#
		def MMatrix.id_vect_range(args, l)
			i = args[0] # the column(/the row) to be change
			vect = args[1] # the values vector
			
		  case args.size
				when 3 then range = args[2] # the range of the elements to be change
				when 4 then range = args[2]..args[3] #the range by borders
				else range = 0...l
			end
			return i, vect, range
		end
		
	end

	#
	# Returns an array with the elements collected from the row "i". 
	# When a block is given, the elements of that vector are iterated.
	#
	def row_collect(i, &block)
		f = MMatrix.default_block(block)
		@rows[i].collect {|e| f.call(e)}
	end

	#
	# Returns row vector number "i" like Matrix.row as a Vector.
	# When the block is given, the elements of row "i" are modified
	#
	def row!(i)
		if block_given?
			@rows[i].collect! {|e| yield e }
		else
			Vector.elements(@rows[i], false)
		end
	end
	alias :row_collect! :row!

	#
	# Returns an array with the elements collected from the column "j". 
	# When a block is given, the elements of that vector are iterated.
	#
	def column_collect(j, &block)
		f = MMatrix.default_block(block)	
		(0...row_size).collect {|r| f.call(self[r, j])}
	end
	
	#
	# Returns column vector number "j" as a Vector.
	# When the block is given, the elements of column "j" are mmodified
	#
	def column!(j)
		if block_given?
			(0...row_size).collect { |i| @rows[i][j] = yield @rows[i][j] }
		else
			column(j)
		end
	end
	alias :column_collect! :column!

	#
	# Set a certain column with the values of a Vector
  # m = Matrix.new(3, 3){|i, j| i * 3 + j + 1}
  # m.column= 1, Vector[1, 1, 1], 1..2
  # m => 1 2 3
  #      4 1 6
  #      7 1 9
	#
	def column=(args)
		m = row_size
		c, v, r = MMatrix.id_vect_range(args, m)
		(m..r.begin - 1).each{|i| self[i, c] = 0}
		[v.size, r.entries.size].min.times{|i| self[i + r.begin, c] = v[i]}
		((v.size + r.begin)..r.entries.last).each {|i| self[i, c] = 0}
	end
	
	#
	# Set a certain row with the values of a Vector
  # m = Matrix.new(3, 3){|i, j| i * 3 + j + 1}
  # m.row= 0, Vector[0, 0], 1..2
  # m => 1 0 0
  #      4 5 6
  #      7 8 9  
	#
	def row=(args)
		i, val, range = MMatrix.id_vect_range(args, column_size) 	
		row!(i)[range] = val
	end

	def norm(p = 2)
    Vector::Norm.sqnorm(self, p) ** (Float(1)/p)
	end
	
	def norm_frobenius
		norm
	end
	alias :normF :norm_frobenius

	#
	# Tests if the matrix is empty or not
	#
	def empty?
		@rows.empty? if @rows
	end

	#
	# Returns the row/s of matrix as a Matrix 
	#
	def row2matrix(r) 
		a = self.send(:row, r).to_a
		if r.is_a?(Range) and r.entries.size > 1
			return Matrix[*a]
		else
			return Matrix[a]
		end
	end

	#
	# Returns the colomn/s of matrix as a Matrix
	#
	def column2matrix(c) 
		a = self.send(:column, c).to_a
		if c.is_a?(Range) and c.entries.size > 1
			return Matrix[*a]
		else
			return Matrix[*a.collect{|x| [x]}]
		end
	end

  module LU
		#
		#	Return the Gauss vector, MC, Golub, 3.2.1 Gauss Transformation, p94
		#
    def LU.gauss_vector(mat, k) 
      t = mat.column2matrix(k)
      tk = t[k, 0]
      (0..k).each{|i| t[i, 0] = 0}
      return t if tk == 0
      (k+1...mat.row_size).each{|i| t[i, 0] = t[i, 0].to_f / tk}
      t
    end

		#
		# Return the Gauss transformation matrix: M_k = I - tau * e_k^T
		#
    def LU.gauss(mat, k)
      i = Matrix.I(mat.column_size)
      tau = gauss_vector(mat, k)
      e = i.row2matrix(k)
      i - tau * e
    end
		
		#
		# LU factorization: A = LU 
		# where L is lower triangular and U is upper triangular
		#
    def LU.factorization(mat)
      u = mat.clone 
			n = u.column_size
			i = Matrix.I(n)
		 	l = i.clone
      (n-1).times {|k| 
				mk = gauss(u, k)
				u = mk * u	# M_{n-1} * ... * M_1 * A = U
				l += i - mk	# L = M_1^{-1} * ... * M_{n-1}^{-1} = I + sum_{k=1}^{n-1} tau * e
			}
			return l, u
    end
  end 
  
	#
	# Return the upper triangular matrix of LU factorization
	# M_{n-1} * ... * M_1 * A = U
	#
	def U
		LU.factorization(self)[1]
	end

	#
	# Return the lower triangular matrix of LU factorization
	# L = M_1^{-1} * ... * M_{n-1}^{-1} = I + sum_{k=1}^{n-1} tau * e
	#
	def L
		LU.factorization(self)[0]
	end

	module Householder
		#
		# a QR factorization that uses Householder transformation
		# Q^T * A = R
		# MC, Golub & van Loan, pg 224, 5.2.1 Householder QR
		#
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

		#
		# From the essential part of Householder vector 
		# it returns the coresponding upper(U_j)/lower(V_j) matrix
		#
		def Householder.bidiagUV(essential, dim, beta)
			v = Vector.concat(Vector[1], essential)
			dimv = v.size
			Matrix.diag(Matrix.I(dim - dimv), Matrix.I(dimv) - beta * (v * v.t) )
		end

		#
		# Householder Bidiagonalization algorithm. MC, Golub, pg 252, Algorithm 5.4.2
		# Returns the matrices U_B and V_B such that: U_B^T * A * V_B = B, 
		# where B is upper bidiagonal.
		#
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
				end	}
			return ub, vb
		end
		
		#
		#Householder Reduction to Hessenberg Form
		#
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

	#
	# Returns the upper bidiagonal matrix obtained with Householder Bidiagonalization algorithm
	#
	def bidiagonal 
		ub, vb = Householder.bidiag(self)
		ub.t * self * vb
	end

	#
	# Returns the orthogonal matrix Q of Householder QR factorization
	# where Q = H_1 * H_2 * H_3 * ... * H_n, 
	#
	def houseQ 
		h = Householder.QR(self)
    q = h[0] 
    (1...h.size).each{|i| q *= h[i]} 
    q
  end

  #
	# Returns the matrix R of Householder QR factorization
	# R = H_n * H_n-1 * ... * H_1 * A is an upper triangular matrix
	#
  def houseR
    h = Householder.QR(self)
    r = self.clone
    h.size.times{|i| r = h[i] * r}
    r
  end

	#
	# Modified Gram Schmidt QR factorization (MC, Golub, p. 232)
	# A = Q_1 * R_1
	#
	def gram_schmidt
		a = clone
		n = column_size
		m = row_size
		q = Matrix.new(m, n){0}
		r = Matrix.zero(n)
		for k in 0...n
			r[k,k] = a[0...m, k].norm
			q[0...m, k] = a[0...m, k] / r[k, k]
			for j in (k+1)...n
				r[k, j] = q[0...m, k].t * a[0...m, j]
				a[0...m, j] -= q[0...m, k] * r[k, j]
			end
		end
		return q, r
	end
	
	#
	# Returns the Q_1 matrix of Modified Gram Schmidt algorithm
	# Q_1 has orthonormal columns
	#
	def gram_schmidtQ
		gram_schmidt[0]
	end

	#
	# Returns the R_1 upper triangular matrix of Modified Gram Schmidt algorithm
	#
	def gram_schmidtR
		gram_schmidt[1]
	end


	module Givens
		#
		# Returns the values "c and s" of a Given rotation
		# MC, Golub, pg 216, Alghorithm 5.1.3
		#
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
	
		# 
		# a QR factorization using Givens rotation
		# Computes the upper triangular matrix R and the orthogonal matrix Q
		# where Q^t A = R (MC, Golub, p227 algorithm 5.2.2)
		#
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
	
	#
	# Returns the upper triunghiular matrix R of a Givens QR factorization
	#
	def givensR
		Givens.QR(self)[0]
	end

	#
	# Returns the orthogonal matrix Q of Givens QR factorization.
	# Q = G_1 * ... * G_t where G_j is the j'th Givens rotation 
	# and 't' is the total number of rotations 
	#
	def givensQ
		Givens.QR(self)[1]
	end

	module Hessenberg
		#
		#	the matrix must be an upper R^(n x n) Hessenberg matrix
		#
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

	#
	# Returns the orthogonal matrix Q of Hessenberg QR factorization
	# Q = G_1 *...* G_(n-1) where G_j is the Givens rotation G_j = G(j, j+1, omega_j)
	#
	def hessenbergQ
		Hessenberg.QR(self)[0]	
	end
	
	#
	# Returns the upper triunghiular matrix R of a Hessenberg QR factorization
	#
	def hessenbergR
		Hessenberg.QR(self)[1]	
	end

	#
	# Return an upper Hessenberg matrix obtained with Householder reduction to Hessenberg Form algorithm 
	#
	def hessenberg_form_H
		Householder.toHessenberg(self)[0]
	end

	#
	# The real Schur decomposition. 
	# The eigenvalues are aproximated in diagonal elements of the real Schur decomposition matrix 
	#
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


	module Jacobi
		#
		# Returns the nurm of the off-diagonal element
		#
		def Jacobi.off(a)
			n = a.row_size
			sum = 0
			n.times{|i| n.times{|j| sum += a[i, j]**2 if j != i}}
			Math.sqrt(sum)
		end

		#
		# Returns the index pair (p, q) with 1<= p < q <= n and A[p, q] is the maximum in absolute value
		#
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
					end	}}
			return p, q
		end

		#
		# Compute the cosine-sine pair (c, s) for the element A[p, q]
		#
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

		#
		# Returns the Jacobi rotation matrix
		#
		def Jacobi.J(p, q, c, s, n)
			j = Matrix.I(n)
			j[p,p] = c; j[p, q] = s
			j[q,p] = -s; j[q, q] = c
			j
		end
	end

	# 
	# Classical Jacobi 8.4.3 Golub & van Loan
	#
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

	#
	# Returns the aproximation matrix computed with Classical Jacobi algorithm.
	# The aproximate eigenvalues values are in the diagonal of the matrix A.
	#
	def cJacobiA(tol = 1.0e-10)
		cJacobi(tol)[0]
	end

	#
	# Returns a Vector with the eigenvalues aproximated values. 
	# The eigenvalues are computed with the Classic Jacobi Algorithm.
	#
	def eigenvaluesJacobi
		a = cJacobiA
		Vector[*(0...row_size).collect{|i| a[i, i]}]
	end

	#
	# Returns the orthogonal matrix obtained with the Jacobi eigenvalue algorithm. 
	# The columns of V are the eigenvector.
	#
	def cJacobiV(tol = 1.0e-10)
		cJacobi(tol)[1]
	end
end


