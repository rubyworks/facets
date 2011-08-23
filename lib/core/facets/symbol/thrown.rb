class Symbol

  # Does the block throw the symbol?
  # 
  def thrown?
    catch(self) do
      begin
        yield
        true
      rescue ArgumentError => err     # 1.9 exception
        false  #msg += ", not #{err.message.split(/ /).last}"
      rescue NameError => err         # 1.8 exception
        false  #msg += ", not #{err.name.inspect}"
      end
    end
  end

end
