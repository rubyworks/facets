module Enumerable

  # Generates a hash mapping each unique symbol in the array
  # to the absolute frequency it appears.
  #
  #   [:a,:a,:b,:c,:c,:c].frequency  #=> {:a=>2,:b=>1,:c=>3}
  #
  # CREDIT: Brian Schröder
  #
  #--
  # NOTE: So why not use #inject here? e.g. ...
  #
  #   inject(Hash.new(0)){|p,v| p[v]+=1; p}
  #
  # Because it is a fair bit slower than the traditional definition.
  #++

  def frequency
    p = Hash.new(0); each{ |v| p[v] += 1 }; p

  end

end

