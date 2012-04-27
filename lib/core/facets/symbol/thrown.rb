class Symbol

  # Does the block throw the symbol?
  # 
  # Note that +throw+ inside the block must be used in one-argument form.
  # 
  # Also note that symbols other than this one are not checked by this method so
  # the following code:
  # 
  #   :a.thrown? { throw :b }
  # 
  # will result in error.
  # 
  def thrown?
    not catch(self) do
      yield
      true
    end
  end

end
