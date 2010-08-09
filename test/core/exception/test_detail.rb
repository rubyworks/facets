Covers 'facets/exception/detail'

Case Exception do

  Unit :detail do
    begin
      raise ArgumentError
    rescue ArgumentError => err
      e = 
      r = err.detail
      r.assert == e
    end
  end

end

