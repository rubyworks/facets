class String

  # String#slice is essentially the same as #store.
  #
  #   a = "HELLO"
  #   a.splice(1, "X")
  #   a                #=> "HXLLO"
  #
  # But it acts like #slice! when given a single argument.
  #
  #   a = "HELLO"
  #   a.splice(1)    #=> "E"
  #   a              #=> "HLLO"
  #
  # CREDIT: Trans

  def splice(idx, sub=nil)
    if sub
      store(idx, sub)
    else
      case idx
      when Range
        slice!(idx)
      else
        slice!(idx,1)
      end
    end
  end

end

