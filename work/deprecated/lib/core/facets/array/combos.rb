class Array

  # Expected to be an enumeration of arrays. This method
  # iterates through combinations of each in position.
  # It produces an array of arrays of all possible combinations
  # of the given arrays in the positions given. (Imagine
  # it like a slot machine dial. This gives every combination
  # that could come up.)
  #
  #   a = [ [0,1], [2,3] ]
  #   a.combo{ |c| p c }
  #
  # produces
  #
  #   [0, 2]
  #   [0, 3]
  #   [1, 2]
  #   [1, 3]
  #
  #   CREDIT: Trans

  def combo(&block)
    if block_given?
      a = collect{ |x|
        x.respond_to?(:to_a) ? x.to_a : 0..x
      }

      if a.size == 1
        r = a.shift
        r.each{ |n|
          yield n
        }
      else
        r = a.shift
        r.each{ |n|
          a.each_combo{ |s|
            yield [n, *s]
          }
        }
      end
    else
      to_enum(:combo)
    end
  end

end

