module Math

  #
  def self.median(array)
    return 0 if array.size == 0
    tmp = array.sort
    mid = tmp.size / 2
    if (tmp.size % 2) == 0
	    (tmp[mid-1] + tmp[mid]).to_f / 2
    else
	    tmp[mid]
    end
  end

end
