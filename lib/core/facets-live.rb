class Object

  def method_missing(methodname, *a, &b)
    # TODO Use #op_esc convert symbolic method names.
    begin
      require "facets/#{class}/#{methodname}"
      # TODO Would it be better to use #methods.include? ?
      if respond_to?(methodname)
        send(methodname, *a, &b)
      end
    rescue LoadError
      super
    end  
  end

end

