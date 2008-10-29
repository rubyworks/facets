module Kernel

  # Assign via accessor methods using a hash, associative
  # array or block.
  #
  #   object.populate( :a => 1, :b => 2 )
  #   object.populate( :a, 1, :b, 2 )
  #   object.populate( [:a, 1], [:b, 2] )
  #   object.populate( *[[:a, 1], [:b, 2]] )
  #   object.populate{ |s| s.a = 1; s.b = 2 }
  #
  # These are all the same as doing:
  #
  #   object.a = 1
  #   object.b = 2
  #
  # Using an associative array instead of hash guarentees 
  # order of assignemnt.
  #
  # Using a hash or array will not raise an error if the
  # accessor does not exits --it will simply be skipped.
  #
  # TODO: Better name, #set_with ?

  def populate(data=nil) #:yield:
    if data
      data.each do |k,v|
        send("#{k}=", v) if respond_to?("#{k}=")
      end
    end
    yield(self) if block_given?
    self
  end

  # Set setter methods using a another object.
  #
  #   class X
  #     attr_accessor :a, :b
  #     def initialize( a, b )
  #        @a,@b = a,b
  #     end
  #   end
  #
  #   obj1 = X.new( 1, 2 )
  #   obj2 = X.new
  #
  #   obj2.set_from(obj1)
  #
  #   obj2.a  #=> 1
  #   obj2.b  #=> 2
  #
  # TODO: pepulate_from(obj) ?

  def set_from(obj, *fields)
    unless fields.empty?
      fields.each do |k|
        send( "#{k}=", obj.send("#{k}") )  #if self.respond_to?("#{k}=") && obj.respond_to?("#{k}")
      end
    else
      setters = methods.collect { |m| m =~ /=$/ }
      setters.each do |setter|
        getter = setter.chomp('=')
        if obj.respond_to?(getter)
          send( setter, obj.send(getter) )
          fields < getter
        end
      end
    end
    fields
  end

end

