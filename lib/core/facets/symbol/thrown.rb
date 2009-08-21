class Symbol

  # Does the block throw the symbol?
  # 
  def thrown?
    catch(self) do
      begin
        yield
        true
      rescue ArgumentError => err     # 1.9 exception
        #msg += ", not #{err.message.split(/ /).last}"
        false
      rescue NameError => err         # 1.8 exception
        #msg += ", not #{err.name.inspect}"
        false
      end
    end
  end

end
