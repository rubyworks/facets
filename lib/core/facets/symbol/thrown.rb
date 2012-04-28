class Symbol

  # Returns truew if the given block throws the symbol, otherwise false.
  # Note that +throw+ inside the block must be used in one-argument form.
  #
  # @return [true,false]
  def thrown?
    thrown = true
    catch(self) do
      begin
        yield
        thrown = false
      rescue ArgumentError => err     # 1.9 exception
        thrown = false if err.message.index('uncaught throw')
      rescue NameError => err         # 1.8 exception
        thrown = false if err.message.index('uncaught throw')
      end
    end
    thrown
  end

end
