covers 'facets/exception/detail'

testcase Exception do

  unit :detail do
    begin
      raise ArgumentError
    rescue ArgumentError => err
      e = 
      r = err.detail
      r.assert == e
    end
  end

end

