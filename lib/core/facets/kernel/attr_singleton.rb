module Kernel

  # Creates singleton attr_readers.
  #
  #   obj = Object.new
  #
  #   obj.attr_singleton_reader :x, :y
  #
  #   attr_singleton_reader :x, :y
  #
  # CREDIT: Trans

  def attr_singleton_reader(*args)
    #h, a = *args.partition{|a| Hash===a}
    (class << self ; self ; end).send( :attr_reader, *args )
    #(class << self ; self ; end).send( :attr_reader, *h.keys )
    #h.each { |k,v| instance_variable_set("@#{k}", v) }
  end

  # Create singleton attr_writers.
  #
  #   obj = Object.new
  #
  #   obj.attr_singleton_writer :x, :y
  #
  #   obj.x = 3
  #   obj.y = 4
  #
  # CREDIT: Trans

  def attr_singleton_writer(*args)
    #h, a = *args.partition{|a| Hash===a}
    (class << self ; self ; end).send( :attr_writer, *args )
    #(class << self ; self ; end).send( :attr_writer, *h.keys )
    #h.each { |k,v| instance_variable_set("@#{k}", v) }
  end

  # Create singleton attr_accessors.
  #
  #   obj = Object.new
  #
  #   obj.attr_singleton_accessor :x, :y
  #
  #   obj.x = 3
  #   obj.y = 4
  #   obj.x      #=> 3
  #   obj.y      #=> 4
  #
  # CREDIT: Trans

  def attr_singleton_accessor(*args)
    #h, a = *args.partition{|a| Hash===a}
    (class << self ; self ; end).send( :attr_accessor, *args )
    #(class << self ; self ; end).send( :attr_accessor, *h.keys )
    #h.each { |k,v| instance_variable_set("@#{k}", v) }
  end

end

