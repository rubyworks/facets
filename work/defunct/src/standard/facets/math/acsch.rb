module Math

  # Area cosecans hyperbolicus of +x+
  def acsch(x)
    ::Math.log(1.0 / x + Math.sqrt(1.0 + 1.0 / (x * x)))
  end

end
