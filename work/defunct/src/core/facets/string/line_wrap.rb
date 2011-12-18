class String

  # Line wrap at width.
  #
  #   s = "1234567890".line_wrap(5)
  #
  #   s  #=> "12345\n67890\n"
  #
  # CREDIT: Trans

  def line_wrap(width, tabs=4)
    s = gsub(/\t/,' ' * tabs) # tabs default to 4 spaces
    s = s.gsub(/\n/,' ')
    r = s.scan( /.{1,#{width}}/ )
    r.join("\n") << "\n"
  end

end
