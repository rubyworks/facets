class String

  # This is basically the same as #store,
  # but it acts like slice! when given only
  # one argument.
  #
  # Essentlay #slice, but writes rather than
  # reads.
  #
  #   a = "HELLO"
  #   a.splice("X", 1)
  #   a                #=> "HXLLO"
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

  # Alias for []=.
  alias_method :store, :[]=

end

