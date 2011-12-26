# = TITLE:
#   Matrix
#
# = SYNOPSIS:
#   An implementation of the Matrix class.
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

require 'rational'

require 'stick/mapcar'

require 'stick/matrix/exception'
require 'stick/matrix/givens'
require 'stick/matrix/householder'
require 'stick/matrix/hessenberg'
require 'stick/matrix/jacobi'
require 'stick/matrix/lu'

require 'stick/vector' unless defined?(Stick::Vector)


module Stick

# The +Matrix+ class represents a mathematical matrix, and provides methods for creating
# special-case matrices (zero, identity, diagonal, singular, vector), operating on them
# arithmetically and algebraically, and determining their mathematical properties (trace, rank,
# inverse, determinant).
#
# Note that although matrices should theoretically be rectangular, this is not
# enforced by the class.
#
# Also note that the determinant of integer matrices may be incorrectly calculated unless you
# also <tt>require 'mathn'</tt>.  This may be fixed in the future.
#
# == Method Catalogue
#
# To create a matrix:
# * <tt> Matrix[*rows]                  </tt>
# * <tt> Matrix.[](*rows)               </tt>
# * <tt> Matrix.rows(rows, copy = true) </tt>
# * <tt> Matrix.columns(columns)        </tt>
# * <tt> Matrix.diagonal(*values)       </tt>
# * <tt> Matrix.scalar(n, value)        </tt>
# * <tt> Matrix.scalar(n, value)        </tt>
# * <tt> Matrix.identity(n)             </tt>
# * <tt> Matrix.unit(n)                 </tt>
# * <tt> Matrix.I(n)                    </tt>
# * <tt> Matrix.zero(n)                 </tt>
# * <tt> Matrix.row_vector(row)         </tt>
# * <tt> Matrix.column_vector(column)   </tt>
#
# To access Matrix elements/columns/rows/submatrices/properties:
# * <tt>  [](i, j)                      </tt>
# * <tt> #row_size                      </tt>
# * <tt> #column_size                   </tt>
# * <tt> #row(i)                        </tt>
# * <tt> #column(j)                     </tt>
# * <tt> #collect                       </tt>
# * <tt> #map                           </tt>
# * <tt> #minor(*param)                 </tt>
#
# Properties of a matrix:
# * <tt> #regular?                      </tt>
# * <tt> #singular?                     </tt>
# * <tt> #square?                       </tt>
#
# Matrix arithmetic:
# * <tt>  *(m)                          </tt>
# * <tt>  +(m)                          </tt>
# * <tt>  -(m)                          </tt>
# * <tt> #/(m)                          </tt>
# * <tt> #inverse                       </tt>
# * <tt> #inv                           </tt>
# * <tt>  **                            </tt>
#
# Matrix functions:
# * <tt> #determinant                   </tt>
# * <tt> #det                           </tt>
# * <tt> #rank                          </tt>
# * <tt> #trace                         </tt>
# * <tt> #tr                            </tt>
# * <tt> #transpose                     </tt>
# * <tt> #t                             </tt>
#
# Conversion to other data types:
# * <tt> #coerce(other)                 </tt>
# * <tt> #row_vectors                   </tt>
# * <tt> #column_vectors                </tt>
# * <tt> #to_a                          </tt>
#
# String representations:
# * <tt> #to_s                          </tt>
# * <tt> #inspect                       </tt>

class Matrix

  include Enumerable

  # instance creations
  private_class_method :new

  # Creates a matrix where each argument is a row.
  #   Matrix[ [25, 93], [-1, 66] ]
  #      =>  25 93
  #          -1 66

  def Matrix.[](*rows)
    new(:init_rows, rows, false)
  end

  # Creates a matrix where +rows+ is an array of arrays, each of which is a row
  # to the matrix.  If the optional argument +copy+ is false, use the given
  # arrays as the internal structure of the matrix without copying.
  #   Matrix.rows([[25, 93], [-1, 66]])
  #      =>  25 93
  #          -1 66

  def Matrix.rows(rows, copy = true)
    new(:init_rows, rows, copy)
  end


  # Creates a matrix using +columns+ as an array of column vectors.
  #   Matrix.columns([[25, 93], [-1, 66]])
  #      =>  25 -1
  #          93 66

  def Matrix.columns(columns)
    rows = (0 .. columns[0].size - 1).collect {
      |i|
      (0 .. columns.size - 1).collect {
        |j|
        columns[j][i]
      }
    }
    rows(rows, false)
  end

  # Creates a matrix where the diagonal elements are composed of +values+.
  #   Matrix.diagonal(9, 5, -3)
  #     =>  9  0  0
  #         0  5  0
  #         0  0 -3

  def Matrix.diagonal(*values)
    size = values.size
    rows = (0 .. size  - 1).collect {
      |j|
      row = Array.new(size).fill(0, 0, size)
      row[j] = values[j]
      row
    }
    rows(rows, false)
  end

  # Creates an +n+ by +n+ diagonal matrix where each diagonal element is
  # +value+.
  #   Matrix.scalar(2, 5)
  #     => 5 0
  #        0 5

  def Matrix.scalar(n, value)
    diagonal(*Array.new(n).fill(value, 0, n))
  end

  # Creates an +n+ by +n+ identity matrix.
  #   Matrix.identity(2)
  #     => 1 0
  #        0 1

  def Matrix.identity(n)
    scalar(n, 1)
  end

  class << Matrix
    alias_method :unit, :identity
    alias_method :I,  :identity
  end

  # Creates an +n+ by +n+ zero matrix.
  #   Matrix.zero(2)
  #     => 0 0
  #        0 0

  def Matrix.zero(n)
    scalar(n, 0)
  end

  # Creates a single-row matrix where the values of that row are as given in
  # +row+.
  #   Matrix.row_vector([4,5,6])
  #     => 4 5 6

  def Matrix.row_vector(row)
    case row
    when Vector
      rows([row.to_a], false)
    when Array
      rows([row.dup], false)
    else
      rows([[row]], false)
    end
  end

  # Creates a single-column matrix where the values of that column are as given
  # in +column+.
  #   Matrix.column_vector([4,5,6])
  #     => 4
  #        5
  #        6

  def Matrix.column_vector(column)
    case column
    when Vector
      columns([column.to_a])
    when Array
      columns([column])
    else
      columns([[column]])
    end
  end

  # This method is used by the other methods that create matrices, and is of no
  # use to general users.

  def initialize(init_method, *argv)
    self.send(init_method, *argv)
  end

  def init_rows(rows, copy)
    if copy
      @rows = rows.collect{|row| row.dup}
    else
      @rows = rows
    end
    self
  end

  private :init_rows

  # Returns element (+i+,+j+) of the matrix.  That is: row +i+, column +j+.

  def [](i, j)
    @rows[i][j]
  end

  alias_method :element, :[]
  alias_method :component, :[]

  def []=(i, j, v)
    @rows[i][j] = v
  end

  alias_method :set_element, :[]=
  alias_method :set_component, :[]=

  private :[]=, :set_element, :set_component

  # Returns the number of rows.

  def row_size
    @rows.size
  end

  # Returns the number of columns.  Note that it is possible to construct a
  # matrix with uneven columns (e.g. Matrix[ [1,2,3], [4,5] ]), but this is
  # mathematically unsound.  This method uses the first row to determine the
  # result.

  def column_size
    @rows[0].size
  end

  # Returns row vector number +i+ of the matrix as a Vector (starting at 0 like
  # an array).  When a block is given, the elements of that vector are iterated.

  def row(i) # :yield: e
    if block_given?
      for e in @rows[i]
        yield e
      end
    else
      Vector.elements(@rows[i])
    end
  end

  # Returns column vector number +j+ of the matrix as a Vector (starting at 0
  # like an array).  When a block is given, the elements of that vector are
  # iterated.

  def column(j) # :yield: e
    if block_given?
      0.upto(row_size - 1) do
        |i|
        yield @rows[i][j]
      end
    else
      col = (0 .. row_size - 1).collect {
        |i|
        @rows[i][j]
      }
      Vector.elements(col, false)
    end
  end

  # Returns a matrix that is the result of iteration of the given block over all
  # elements of the matrix.
  #   Matrix[ [1,2], [3,4] ].collect { |e| e**2 }
  #     => 1  4
  #        9 16

  def collect # :yield: e
    rows = @rows.collect{|row| row.collect{|e| yield e}}
    Matrix.rows(rows, false)
  end
  alias map collect

  # Returns a section of the matrix.  The parameters are either:
  # *  start_row, nrows, start_col, ncols; OR
  # *  col_range, row_range
  #
  #   Matrix.diagonal(9, 5, -3).minor(0..1, 0..2)
  #     => 9 0 0
  #        0 5 0

  def minor(*param)
    case param.size
    when 2
      from_row = param[0].first
      size_row = param[0].end - from_row
      size_row += 1 unless param[0].exclude_end?
      from_col = param[1].first
      size_col = param[1].end - from_col
      size_col += 1 unless param[1].exclude_end?
    when 4
      from_row = param[0]
      size_row = param[1]
      from_col = param[2]
      size_col = param[3]
    else
      Matrix.Raise ArgumentError, param.inspect
    end

    rows = @rows[from_row, size_row].collect{
      |row|
      row[from_col, size_col]
    }
    Matrix.rows(rows, false)
  end

  #--
  # TESTING -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  #++

  #
  # Returns +true+ if this is a regular matrix.
  #
  def regular?
    square? and rank == column_size
  end

  #
  # Returns +true+ is this is a singular (i.e. non-regular) matrix.
  #
  def singular?
    not regular?
  end

  #
  # Returns +true+ is this is a square matrix.  See note in column_size about this
  # being unreliable, though.
  #
  def square?
    column_size == row_size
  end

  #--
  # OBJECT METHODS -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  #++

  # Returns +true+ if and only if the two matrices contain equal elements.

  def ==(other)
    return false unless Matrix === other

    other.compare_by_row_vectors(@rows)
  end
  alias eql? ==

  # Not really intended for general consumption.

  def compare_by_row_vectors(rows)
    return false unless @rows.size == rows.size

    0.upto(@rows.size - 1) do
      |i|
      return false unless @rows[i] == rows[i]
    end
    true
  end

  # Returns a clone of the matrix, so that the contents of each do not reference
  # identical objects.

  def clone
    Matrix.rows(@rows)
  end

  # Returns a hash-code for the matrix.

  def hash
    value = 0
    for row in @rows
      for e in row
        value ^= e.hash
      end
    end
    return value
  end

  #--
  # ARITHMETIC -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  #++

  # Matrix multiplication.
  #   Matrix[[2,4], [6,8]] * Matrix.identity(2)
  #     => 2 4
  #        6 8

  def *(m) # m is matrix or vector or number
    case(m)
    when Numeric
      rows = @rows.collect {
        |row|
        row.collect {
          |e|
          e * m
        }
      }
      return Matrix.rows(rows, false)
    when Vector
      m = Matrix.column_vector(m)
      r = self * m
      return r.column(0)
    when Matrix
      Matrix.Raise ErrDimensionMismatch if column_size != m.row_size

      rows = (0 .. row_size - 1).collect {
        |i|
        (0 .. m.column_size - 1).collect {
          |j|
          vij = 0
          0.upto(column_size - 1) do
            |k|
            vij += self[i, k] * m[k, j]
          end
          vij
        }
      }
      return Matrix.rows(rows, false)
    else
      x, y = m.coerce(self)
      return x * y
    end
  end

  # Matrix addition.
  #   Matrix.scalar(2,5) + Matrix[[1,0], [-4,7]]
  #     =>  6  0
  #        -4 12

  def +(m)
    case m
    when Numeric
      Matrix.Raise ErrOperationNotDefined, "+"
    when Vector
      m = Matrix.column_vector(m)
    when Matrix
    else
      x, y = m.coerce(self)
      return x + y
    end

    Matrix.Raise ErrDimensionMismatch unless row_size == m.row_size and column_size == m.column_size

    rows = (0 .. row_size - 1).collect {
      |i|
      (0 .. column_size - 1).collect {
        |j|
        self[i, j] + m[i, j]
      }
    }
    Matrix.rows(rows, false)
  end

  # Matrix subtraction.
  #   Matrix[[1,5], [4,2]] - Matrix[[9,3], [-4,1]]
  #     => -8  2
  #         8  1

  def -(m)
    case m
    when Numeric
      Matrix.Raise ErrOperationNotDefined, "-"
    when Vector
      m = Matrix.column_vector(m)
    when Matrix
    else
      x, y = m.coerce(self)
      return x - y
    end

    Matrix.Raise ErrDimensionMismatch unless row_size == m.row_size and column_size == m.column_size

    rows = (0 .. row_size - 1).collect {
      |i|
      (0 .. column_size - 1).collect {
        |j|
        self[i, j] - m[i, j]
      }
    }
    Matrix.rows(rows, false)
  end

  # Matrix division (multiplication by the inverse).
  #   Matrix[[7,6], [3,9]] / Matrix[[2,9], [3,1]]
  #     => -7  1
  #        -3 -6

  def /(other)
    case other
    when Numeric
      rows = @rows.collect {
        |row|
        row.collect {
          |e|
          e / other
        }
      }
      return Matrix.rows(rows, false)
    when Matrix
      return self * other.inverse
    else
      x, y = other.coerce(self)
      rerurn x / y
    end
  end

  # Returns the inverse of the matrix.
  #   Matrix[[1, 2], [2, 1]].inverse
  #     => -1  1
  #         0 -1

  def inverse
    Matrix.Raise ErrDimensionMismatch unless square?
    Matrix.I(row_size).inverse_from(self)
  end
  alias inv inverse

  # Not for public consumption?

  def inverse_from(src)
    size = row_size - 1
    a = src.to_a

    for k in 0..size
      i = k
      akk = a[k][k].abs
      for j in (k+1)..size
        v = a[j][k].abs
        if v > akk
          i = j
          akk = v
        end
      end
      Matrix.Raise ErrNotRegular if akk == 0
      if i != k
        a[i], a[k] = a[k], a[i]
        @rows[i], @rows[k] = @rows[k], @rows[i]
      end
      akk = a[k][k]

      for i in 0 .. size
        next if i == k
        q = a[i][k].quo(akk)
        a[i][k] = 0

        (k + 1).upto(size) do
          |j|
          a[i][j] -= a[k][j] * q
        end
        0.upto(size) do
          |j|
          @rows[i][j] -= @rows[k][j] * q
        end
      end

      (k + 1).upto(size) do
        |j|
        a[k][j] = a[k][j].quo(akk)
      end
      0.upto(size) do
        |j|
        @rows[k][j] = @rows[k][j].quo(akk)
      end
    end
    self
  end

  #alias_method :reciprocal, :inverse


  # Matrix exponentiation.  Defined for integer powers only.  Equivalent to
  # multiplying the matrix by itself N times.
  #   Matrix[[7,6], [3,9]] ** 2
  #     => 67 96
  #        48 99

  def ** (other)
    if other.kind_of?(Integer)
      x = self
      if other <= 0
        x = self.inverse
        return Matrix.identity(self.column_size) if other == 0
        other = -other
      end
      z = x
      n = other  - 1
      while n != 0
        while (div, mod = n.divmod(2)
               mod == 0)
          x = x * x
          n = div
        end
        z *= x
        n -= 1
      end
      z
    elsif other.kind_of?(Float) || defined?(Rational) && other.kind_of?(Rational)
      Matrix.Raise ErrOperationNotDefined, "**"
    else
      Matrix.Raise ErrOperationNotDefined, "**"
    end
  end

  #--
  # MATRIX FUNCTIONS -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  #++

  # Returns the determinant of the matrix.  If the matrix is not square, the
  # result is 0. This method's algorism is Gaussian elimination method
  # and using Numeric#quo(). Beware that using Float values, with their
  # usual lack of precision, can affect the value returned by this method.  Use
  # Rational values or Matrix#det_e instead if this is important to you.
  #
  #   Matrix[[7,6], [3,9]].determinant
  #     => 63.0

  def determinant
    return 0 unless square?

    size = row_size - 1
    a = to_a

    det = 1
    k = 0
    begin
      if (akk = a[k][k]) == 0
        i = k
        begin
          return 0 if (i += 1) > size
        end while a[i][k] == 0
        a[i], a[k] = a[k], a[i]
        akk = a[k][k]
        det *= -1
      end
      (k + 1).upto(size) do
        |i|
        q = a[i][k].quo(akk)
        (k + 1).upto(size) do
          |j|
          a[i][j] -= a[k][j] * q
        end
      end
      det *= akk
    end while (k += 1) <= size
    det
  end

  alias_method :det, :determinant

  # Returns the determinant of the matrix.  If the matrix is not square, the
  # result is 0. This method's algorism is Gaussian elimination method.
  # This method uses Euclidean algorism. If all elements are integer,
  # really exact value. But, if an element is a float, can't return
  # exact value.
  #
  #   Matrix[[7,6], [3,9]].determinant
  #     => 63

  def determinant_e
    return 0 unless square?

    size = row_size - 1
    a = to_a

    det = 1
    k = 0
    begin
      if a[k][k].zero?
        i = k
        begin
          return 0 if (i += 1) > size
        end while a[i][k].zero?
        a[i], a[k] = a[k], a[i]
        det *= -1
      end
      (k + 1).upto(size) do |i|
        q = a[i][k].quo(a[k][k])
        k.upto(size) do |j|
          a[i][j] -= a[k][j] * q
        end
        unless a[i][k].zero?
          a[i], a[k] = a[k], a[i]
          det *= -1
          redo
        end
      end
      det *= a[k][k]
    end while (k += 1) <= size
    det
  end

  alias_method :det_e, :determinant_e

  # Returns the rank of the matrix. Beware that using Float values,
  # probably return faild value. Use Rational values or Matrix#rank_e
  # for getting exact result.
  #
  #   Matrix[[7,6], [3,9]].rank
  #     => 2

  def rank
    if column_size > row_size
      a = transpose.to_a
      a_column_size = row_size
      a_row_size = column_size
    else
      a = to_a
      a_column_size = column_size
      a_row_size = row_size
    end
    rank = 0
    k = 0
    begin
      if (akk = a[k][k]) == 0
        i = k
        exists = true
        begin
          if (i += 1) > a_column_size - 1
            exists = false
            break
          end
        end while a[i][k] == 0
        if exists
          a[i], a[k] = a[k], a[i]
          akk = a[k][k]
        else
          i = k
          exists = true
          begin
            if (i += 1) > a_row_size - 1
              exists = false
              break
            end
          end while a[k][i] == 0
          if exists
            k.upto(a_column_size - 1) do
              |j|
              a[j][k], a[j][i] = a[j][i], a[j][k]
            end
            akk = a[k][k]
          else
            next
          end
        end
      end
      (k + 1).upto(a_row_size - 1) do
        |i|
        q = a[i][k].quo(akk)
        (k + 1).upto(a_column_size - 1) do
          |j|
          a[i][j] -= a[k][j] * q
        end
      end
      rank += 1
    end while (k += 1) <= a_column_size - 1
    return rank
  end

  # Returns the rank of the matrix. This method uses Euclidean
  # algorism. If all elements are integer, really exact value. But, if
  # an element is a float, can't return exact value.
  #
  #   Matrix[[7,6], [3,9]].rank
  #     => 2

  def rank_e
    a = to_a
    a_column_size = column_size
    a_row_size = row_size
    pi = 0
    (0 ... a_column_size).each do |j|
      if i = (pi ... a_row_size).find{|i0| !a[i0][j].zero?}
        if i != pi
          a[pi], a[i] = a[i], a[pi]
        end
        (pi + 1 ... a_row_size).each do |k|
          q = a[k][j].quo(a[pi][j])
          (pi ... a_column_size).each do |j0|
            a[k][j0] -= q * a[pi][j0]
          end
          if k > pi && !a[k][j].zero?
            a[k], a[pi] = a[pi], a[k]
            redo
          end
        end
        pi += 1
      end
    end
    pi
  end

  # Returns the trace (sum of diagonal elements) of the matrix.
  #   Matrix[[7,6], [3,9]].trace
  #     => 16

  def trace
    tr = 0
    0.upto(column_size - 1) do
      |i|
      tr += @rows[i][i]
    end
    tr
  end

  alias_method :tr, :trace

  # Returns the transpose of the matrix.
  #   Matrix[[1,2], [3,4], [5,6]]
  #     => 1 2
  #        3 4
  #        5 6
  #   Matrix[[1,2], [3,4], [5,6]].transpose
  #     => 1 3 5
  #        2 4 6

  def transpose
    Matrix.columns(@rows)
  end

  alias_method :t, :transpose

  #--
  # CONVERTING -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  #++

  # FIXME: describe #coerce.

  def coerce(other)
    case other
    when Numeric
      return Scalar.new(other), self
    else
      raise TypeError, "#{self.class} can't be coerced into #{other.class}"
    end
  end

  # Returns an array of the row vectors of the matrix.  See Vector.

  def row_vectors
    rows = (0 .. row_size - 1).collect {
      |i|
      row(i)
    }
    rows
  end

  # Returns an array of the column vectors of the matrix.  See Vector.

  def column_vectors
    columns = (0 .. column_size - 1).collect {
      |i|
      column(i)
    }
    columns
  end

  # Returns an array of arrays that describe the rows of the matrix.

  def to_a
    @rows.collect{|row| row.collect{|e| e}}
  end

  def elements_to_f
    collect{|e| e.to_f}
  end

  def elements_to_i
    collect{|e| e.to_i}
  end

  def elements_to_r
    collect{|e| e.to_r}
  end

  #--
  # PRINTING -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  #++

  # Overrides Object#to_s

  def to_s
    "Matrix[" + @rows.collect{
      |row|
      "[" + row.collect{|e| e.to_s}.join(", ") + "]"
    }.join(", ")+"]"
  end

  # Overrides Object#inspect

  def inspect
    "Matrix"+@rows.inspect
  end

  # Private CLASS

  class Scalar < Numeric # :nodoc:

    include Matrix::Exceptions

    def initialize(value)
      @value = value
    end

    # ARITHMETIC
    def +(other)
      case other
      when Numeric
        Scalar.new(@value + other)
      when Vector, Matrix
        Scalar.Raise WrongArgType, other.class, "Numeric or Scalar"
      when Scalar
        Scalar.new(@value + other.value)
      else
        x, y = other.coerce(self)
        x + y
      end
    end

    def -(other)
      case other
      when Numeric
        Scalar.new(@value - other)
      when Vector, Matrix
        Scalar.Raise WrongArgType, other.class, "Numeric or Scalar"
      when Scalar
        Scalar.new(@value - other.value)
      else
        x, y = other.coerce(self)
        x - y
      end
    end

    def *(other)
      case other
      when Numeric
        Scalar.new(@value * other)
      when Vector, Matrix
        other.collect{|e| @value * e}
      else
        x, y = other.coerce(self)
        x * y
      end
    end

    def / (other)
      case other
      when Numeric
        Scalar.new(@value / other)
      when Vector
        Scalar.Raise WrongArgType, other.class, "Numeric or Scalar or Matrix"
      when Matrix
        self * other.inverse
      else
        x, y = other.coerce(self)
        x.quo(y)
      end
    end

    def ** (other)
      case other
      when Numeric
        Scalar.new(@value ** other)
      when Vector
        Scalar.Raise WrongArgType, other.class, "Numeric or Scalar or Matrix"
      when Matrix
        other.powered_by(self)
      else
        x, y = other.coerce(self)
        x ** y
      end
    end

  end

  #--
  # EXTENSION BY Cosmin Bonchis -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  #++

  public_class_method :new

  attr_reader :rows, :wrap

  @wrap = nil

  def initialize(*argv)
    return initialize_old(*argv) if argv[0].is_a?(Symbol)
    n, m, val = argv; val = 0 if not val
    f = (block_given?)? lambda {|i,j| yield(i, j)} : lambda {|i,j| val}
    init_rows((0...n).collect {|i| (0...m).collect {|j| f.call(i,j)}}, true)
  end

  # For invoking a method
  # in Ruby1.8 is working 'send' and
  # in Ruby1.9 is working 'funcall'

  def initialize_old(init_method, *argv)
    if RUBY_VERSION < "1.9.0"
      self.send(init_method, *argv) # in Ruby1.8
    else
      self.funcall(init_method, *argv) # in Ruby1.9
    end
  end

  alias_method :ids, :[]

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

  # Set the values of a matrix
  # m = Matrix.new(3, 3){|i, j| i * 3 + j}
  # m: 0  1  2
  #    3  4  5
  #    6  7  8
  # m[1, 2] = 9 => Matrix[[0, 1, 2], [3, 4, 9], [6, 7, 8]]
  # m[2,1..2] = Vector[8, 8] => Matrix[[0, 1, 2], [3, 8, 8], [6, 7, 8]]
  # m[0..1, 0..1] = Matrix[[0, 0, 0],[0, 0, 0]]
  #     => Matrix[[0, 0, 2], [0, 0, 8], [6, 7, 8]]

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

  # Return a clone matrix

  def clone
    super
  end

  def initialize_copy(orig)
    init_rows(orig.rows, true)
    self.wrap=(orig.wrap)
  end


  class << self

    # Creates a matrix with the given matrices as diagonal blocks

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

    # Tests if all the elements of two matrix are equal in delta

    def equal_in_delta?(m0, m1, delta = 1.0e-10)
      delta = delta.abs
      mapcar(m0, m1){|x, y| return false if (x < y - delta or x > y + delta)  }
      true
    end

    # Tests if all the diagonal elements of two matrix are equal in delta

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

  def quo(v)
    map {|e| e.quo(v)}
  end

  # quo seems always desirable

  alias_method :/, :quo

  # Set de values of a matrix and the value of wrap property

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

  # Iterate the elements of a matrix

  def each
    @rows.each {|x| x.each {|e| yield(e)}}
    nil
  end

  # A hidden module of Matrix.

  module MMatrix

    def self.default_block(block)
      block ? lambda { |i| block.call(i) } : lambda {|i| i }
    end

    # Returns:
    # 1) the index of row/column and
    # 2) the values Vector for changing the row/column and
    # 3) the range of changes
    #
    def self.id_vect_range(args, l)
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

  # Returns an array with the elements collected from the row "i".
  # When a block is given, the elements of that vector are iterated.

  def row_collect(i, &block)
    f = MMatrix.default_block(block)
    @rows[i].collect {|e| f.call(e)}
  end

  # Returns row vector number "i" like Matrix.row as a Vector.
  # When the block is given, the elements of row "i" are modified

  def row!(i)
    if block_given?
      @rows[i].collect! {|e| yield e }
    else
      Vector.elements(@rows[i], false)
    end
  end

  alias_method :row_collect!, :row!

  # Returns an array with the elements collected from the column "j".
  # When a block is given, the elements of that vector are iterated.

  def column_collect(j, &block)
    f = MMatrix.default_block(block)
    (0...row_size).collect {|r| f.call(self[r, j])}
  end

  # Returns column vector number "j" as a Vector.
  # When the block is given, the elements of column "j" are mmodified

  def column!(j)
    if block_given?
      (0...row_size).collect { |i| @rows[i][j] = yield @rows[i][j] }
    else
      column(j)
    end
  end

  alias_method :column_collect!, :column!

  # Set a certain column with the values of a Vector
  # m = Matrix.new(3, 3){|i, j| i * 3 + j + 1}
  # m.column= 1, Vector[1, 1, 1], 1..2
  # m => 1 2 3
  #      4 1 6
  #      7 1 9

  def column=(args)
    m = row_size
    c, v, r = MMatrix.id_vect_range(args, m)
    (m..r.begin - 1).each{|i| self[i, c] = 0}
    [v.size, r.entries.size].min.times{|i| self[i + r.begin, c] = v[i]}
    ((v.size + r.begin)..r.entries.last).each {|i| self[i, c] = 0}
  end

  # Set a certain row with the values of a Vector
  # m = Matrix.new(3, 3){|i, j| i * 3 + j + 1}
  # m.row= 0, Vector[0, 0], 1..2
  # m => 1 0 0
  #      4 5 6
  #      7 8 9

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

  alias_method :normF, :norm_frobenius

  # Tests if the matrix is empty or not

  def empty?
    @rows.empty? if @rows
  end

  # Returns the row/s of matrix as a Matrix

  def row2matrix(r)
    a = self.send(:row, r).to_a
    if r.is_a?(Range) and r.entries.size > 1
      return Matrix[*a]
    else
      return Matrix[a]
    end
  end

  # Returns the colomn/s of matrix as a Matrix

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

  def gram_schmidt
    a = dup #clone
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

  def gram_schmidtQ
    gram_schmidt[0]
  end

  # Returns the R_1 upper triangular matrix of Modified Gram Schmidt algorithm

  def gram_schmidtR
    gram_schmidt[1]
  end

end # class Matrix
end # module Stick
