class Module

  def mapped_accessor(field, mapped_field, mapping)
    reverse_mapping = mapping.invert

    attr_accessor(field) if not respond_to?(field)

    meta_def("#{field}_to_#{mapped_field}") do |value|
      mapping[value]
    end

    meta_def("#{mapped_field}_to_#{field}") do |value|
      reverse_mapping[value]
    end

    define_method(mapped_field) do
      mapping[send(field)]
    end

    define_method("#{mapped_field}=") do |value|
      send("#{field}=", reverse_mapping[value])
    end
  end

end
