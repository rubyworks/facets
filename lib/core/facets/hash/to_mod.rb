class Hash

  # Convert a hash into a module.
  #
  #   {:a=>1, :b=>2}.to_mod
  #
  # Can take a block accepting key, value pairs which will be
  # evaluated in the context of the module.
  #
  #   h = {:a=>1, :b=>2}
  #   m = h.to_mod{ |k,v| module_function k }
  #   m.a #=> 1
  #   m.b #=> 2
  #
  # CREDIT: Jay Fields
  #--
  # TODO: Consider #to_obj?
  #++

  def to_mod(&block)
    hash = self
    Module.new do
      hash.each do |key, value|
        define_method key do
          value #.to_object
        end
        instance_exec(key, value, &block) if block
      end
    end
  end

end

