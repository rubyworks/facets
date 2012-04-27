class Symbol

  # Does a given block throw the symbol?
  # 
  # Note that +throw+ inside the block must be used in one-argument form. Also,
  # note that this definition is not 100% perfect in that it can cause a false
  # positive if an ArgumentError is thrown by the block and the error message
  # contains the text `uncaught throw`, even though it is not actually the
  # error. That, of course, is not likely to ever happen, so it's Good Enough(TM).
  #
  # Ideally Ruby would provide a more specific error message (See http://bugs.ruby-lang.org/issues/6372)
  #
  def thrown?
    catch(self) do
      begin
        yield
        true
      rescue ArgumentError => err     # 1.9 exception
        false if err.message.index('uncaught throw')
      rescue NameError => err         # 1.8 exception
        false if err.message.index('uncaught throw')
      end
    end
  end

end
