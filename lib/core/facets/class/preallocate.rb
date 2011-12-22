class Class

  # Designate aspect modules to be added to a object at instantiation.
  #
  #   class Firetruck
  #     def put_out_fire(option)
  #       "Put out #{option}"
  #     end
  #   end
  #
  #   module FastFiretruck
  #     def put_out_fire(option)
  #       super("very #{option}!")
  #     end
  #   end
  #
  #   Firetruck.preallocate(FastFiretruck)
  #
  #   ft = Firetruck.new
  #   ft.put_out_fire('fast') #=> "Put out very fast!"
  #
  # This method is very similar to the idea of #prepend, but it has some
  # limitations in that it works by overriding #new and #allocate and extends
  # an object with the aspect modules on instantiation. A true #prepend
  # implementation would not have to do this --but would be a natural part
  # of the class heirarchy instead. For this reason, this method has been
  # named #preallocate, rather than #prepend.
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: Trans
  #
  # @uncommon
  #   require 'facets/class/preallocate'
  #
  def preallocate(aspect)
    _new      = method(:new)
    _allocate = method(:allocate)
    (class << self; self; end).class_eval do
      define_method(:new) do |*args|
        o = _new.call(*args)
        o.extend aspect
        o
      end
      define_method(:allocate) do |*args|
        o = _allocate.call(*args)
        o.extend aspect
        o
      end
    end
  end

end

