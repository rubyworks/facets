require 'rational'

require 'euclid/matrix/core'
require 'euclid/matrix/exception'
require 'euclid/matrix/givens'
require 'euclid/matrix/hessenberg'
require 'euclid/matrix/householder'
require 'euclid/matrix/jacobi'
require 'euclid/matrix/lu'

#
class Matrix

  include Enumerable

  public_class_method :new

  @wrap = nil

  attr_reader :rows, :wrap

  #
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
  #     => Matrix[[0, 0, 2], [0, 0, 8], [6, 7, 8]]
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

  # Returns the matrix divided by a scalar
  #
  def quo(v)
    map{ |e| e.quo(v) }
  end

  # quo seems always desirable
  #
  alias :/ :quo

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

  # Returns the maximum length of column elements
  #
  def max_len_column(j)
    column_collect(j) {|x| x.to_s.length}.max
  end

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

  # Returns the Q_1 matrix of Modified Gram Schmidt algorithm
  # Q_1 has orthonormal columns
  #
  def gram_schmidtQ
    gram_schmidt[0]
  end

  # Returns the R_1 upper triangular matrix of Modified Gram Schmidt algorithm
  #
  def gram_schmidtR
    gram_schmidt[1]
  end

private

  # Non-recursive mapcar (works on all Enumerables)
  #
  # NOTE: Is this basically the same as transpose, but taking a block?
  #
  def mapcar(*enums)
    generators = enums.collect { |e| Generator.new(e) }
    result = []
    while true
      begin
        params = generators.collect{ |g| g.current; g.next }
      rescue EOFError
        return result
      end
      result << yield(*params)
    end
  end

end

