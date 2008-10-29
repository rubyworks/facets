class String

  # Line wrap at width.
  #
  #   puts "1234567890".line_wrap(5)
  #
  # _produces_
  #
  #   12345
  #   67890
  #
  #  CREDIT: Trans

  def line_wrap(width, tabs=4)
    s = gsub(/\t/,' ' * tabs) # tabs default to 4 spaces
    s = s.gsub(/\n/,' ')
    r = s.scan( /.{1,#{width}}/ )
    r.join("\n") << "\n"
  end

end
