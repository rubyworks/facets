class Object

  # PHPic extract().
  # Hash will be injected into self as instance variables (@var).
  #
  # Example
  #
  #   extract({'cmd'=>'hello','page'=>'frontpage'})
  #   @cmd #=> 'hello'
  #
  # CREDIT: T. Yamada

  def extract(h,overwrite=false)
    h.each do |k,v|
      if overwrite || !instance_variable_defined?('@'+k.to_s) then
        instance_variable_set('@'+k.to_s,v)
      end
    end
  end
end
