class Module

  def subfield_accessors(field, subfields)
    subfields.each do |subfield, index|
      define_method(subfield) do
        self.send(field)[index]
      end

      define_method("#{subfield}=") do |value|
        self.send(field)[index] = value
      end
    end
  end

end
