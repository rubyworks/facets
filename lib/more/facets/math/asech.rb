module Math

  # Area secans hyperbolicus of +x+
  def asech(x)
    log((1.0 + sqrt(1.0 - x * x)) / x)
  end

end
