class Range

  # Subtract one range from another producing a range array.
  #
  # Examples
  #
  #     (1..10) - (4..6)  => [1..3, 7..10]
  #
  #     (1..10) - (9..12) => [1..8]
  #
  # Returns [Array]
  #
  # CREDIT: monocle

	def -(value)
		if value.class == first.class
			minus_obj(value)
		else
			[minus_obj(value.first)[0], minus_obj(value.last)[1]].compact
		end
	end

	private

    # TODO: Better name? Maybe make public?
	  def minus_obj(value)
		  f = case value <=> first.succ
		      when -1 then nil
       		when  0 then first
	       	else
       		  #value < last.succ ? first...value : self
       		  value < last.succ ? first..(value.pred) : self
          end

		  s = case last <=> value.succ
          when -1 then nil
          when  0 then last
          else
            value.succ > first ? (value.succ)..last : self
          end

		  [f, s]
	  end

end
