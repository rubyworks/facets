class Hash

  # Convert a hash into a mixin.
  #
  # CREDIT: Jay Fields
  #
  #--
  # TODO: Consider #to_object option.
  #++

  def to_module
    hash = self
    Module.new do
      hash.each do |key, value|
        define_method key do
          value #.to_object
        end
      end
    end
  end

  #def to_object
  #  Object.new.extend(to_module)
  #end
end

