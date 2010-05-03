require 'facets/string/interpolate'

Case String do

  Unit :nterpolate do
    a = 1
    String.interpolate{ 'this is #{a}' }.assert == 'this is 1'
  end

end


