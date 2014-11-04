require 'facets/array/arrange'

class Array

  # Determine the "holes" in the values of an array.
  #
  # TODO: Better name?
  #
	# Returns the missing elements in an array set.
  #
  # CREDIT: monocle

	def missing
		missing, array = [], arrange
		i, length = 0, array.size - 1
		while i < length 
      x0 = array[i]
      x1 = array[i+1]
			c = (Range === x0 ? x0.last  : x0)
			n = (Range === x1 ? x1.first : x1)
			missing << (
        c.succ.succ == n ? c.succ : ((c.succ)..(n.pred))
      )
			i += 1
		end
    return missing
	end

end
