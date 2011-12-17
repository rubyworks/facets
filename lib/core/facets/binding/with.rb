class Binding

  # Returns a new binding with local varaibles set.
  #
  # CREDIT: Trans

  def with(_local_variables, &_yields)
    eval("lambda{ |#{_local_variables.keys.join(',')},&yields| binding }").call(*_local_variables.values, &_yields)
  end

end

