module Kernel

  # Takes an array or a hash with default values and creates
  # singleton attr_readers for each.
  #
  #   attr_singleton_reader {:x => 1, :y => 2}
  #   @x       #=> 1
  #   @y       #=> 2
  #   self.x   #=> 1
  #   self.y   #=> 2
  #
  #  CREDIT: Trans

  def attr_singleton_reader(*args)
    #h, a = *args.partition{|a| Hash===a}
    (class << self ; self ; end).send( :attr_reader, *args )  
    #(class << self ; self ; end).send( :attr_reader, *h.keys )
    #h.each { |k,v| instance_variable_set("@#{k}", v) }
  end

  # Takes an array or a hash with default values and creates 
  # singleton attr_writers for each.
  #
  #   attr_singleton_writer { :x => 1, :y => 2 }
  #   @x           #=> 1
  #   @y           #=> 2
  #   self.x = 3
  #   self.y = 4
  #   @x           #=> 3
  #   @y           #=> 4
  #
  #  CREDIT: Trans

  def attr_singleton_writer(*args)
    #h, a = *args.partition{|a| Hash===a}
    (class << self ; self ; end).send( :attr_writer, *args )
    #(class << self ; self ; end).send( :attr_writer, *h.keys )
    #h.each { |k,v| instance_variable_set("@#{k}", v) }
  end

  # Takes an array or hash with default values and creates
  # singleton attr_accessors for each.
  #
  #   attr_singleton_accessor { :x => 1, :y => 2 }
  #   @x          #=> 1
  #   @y          #=> 2
  #   self.x = 3
  #   self.y = 4
  #   self.x      #=> 3
  #   self.y      #=> 4
  #
  #  CREDIT: Trans

  def attr_singleton_accessor(*args)
    #h, a = *args.partition{|a| Hash===a}
    (class << self ; self ; end).send( :attr_accessor, *args )
    #(class << self ; self ; end).send( :attr_accessor, *h.keys )
    #h.each { |k,v| instance_variable_set("@#{k}", v) }
  end

end

