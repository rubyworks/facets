class Array

	# Returns the values in common for an array set (nil, single value/object, or range).
  #
  # CREDIT: monocle

	def intersection
		array = uniq.sort_by { |e| Range === e ? e.first : e }
		array.inject() do |c, e|
			f = (Range === c ? c.last  : c)
			v = (Range === e ? e.first : e)
			case f <=> v
			when -1 then return nil
			when  0 then f
			else
				if Range === e
					v..([f, e.last].min)
				else
					v
				end
			end
		end
	end

end
