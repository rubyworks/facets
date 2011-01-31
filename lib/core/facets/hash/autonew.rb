class Hash

  # Hash which auto initializes it's children.
  #
  #   h = Hash.autonew
  #   h['s1']['p1'] = 4
  #   h['s1']['p2'] = 5
  #   h['s1']['p3'] = 2
  #   h['s1']['p4'] = 3
  #
  #   h #=> {"s1"=>{"p1"=>4, "p4"=>3, "p3"=>2, "p2"=>5}}
  #
  #   h['s1'].keys.sort
  #   #=> ["p1", "p2", "p3", "p4"]
  #
  # CREDIT: Trans, Jan Molic

  def self.autonew(*args)
    leet = lambda{ |hsh, key| hsh[key] = new( &leet ) }
    new(*args,&leet)
  end

end

