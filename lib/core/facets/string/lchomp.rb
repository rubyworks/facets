class String

  # Left chomp. Alias for #delete_prefix.
  #
  #   "help".lchomp("h")  #=> "elp"
  #   "help".lchomp("k")  #=> "help"
  #
  # CREDIT: Trans

  def lchomp(match)
    delete_prefix(match)
  end

  # In-place left chomp. Alias for #delete_prefix!.
  #
  #   s = "help"
  #   s.lchomp!("h")  #=> "elp"
  #   s                #=> "elp"
  #
  # CREDIT: Trans

  def lchomp!(match)
    delete_prefix!(match)
  end

end
