module Enumerable

  def apply(*method_names)
    self.collect do |item|
      method_names.each do |method_name|
        if item.kind_of?(Hash) and (['id', :id].include?(method_name) or not item.respond_to?(method_name))
          item = item[method_name]
        else
          item = item.send(method_name)
        end
      end
      item
    end
  end

end
