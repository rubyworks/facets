class Class

  # Prepend an "aspect module" to a class.
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
  #   Firetruck.prepend(FastFiretruck)
  #
  #   ft = Firetruck.new
  #   ft.put_out_fire('fast') #=> "Put out very fast!"
  #
  # Implementation of this method has some limitations,
  # in that it works by overriding #new and #allocate.
  #
  # CREDIT Trans
  #
  # TODO: Perhaps rename this to preallocate, b/c of
  #       the way it works. It is not really a clean
  #       prepend, like that of Module#prepend.

  def prepend( aspect )
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

  #alias_method :preallocate, :prepend
end

