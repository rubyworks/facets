class String

  # Word wrap a string not exceeding max width.
  #
  #   puts "this is a test".word_wrap(4)
  #
  # _produces_
  #
  #   this
  #   is a
  #   test
  #
  # This is basic implementation of word wrap, but smart
  # enough to suffice for most use cases.
  #
  #  CREDIT: Gavin Kistner
  #  CREDIT: Dayne Broderson
  #
  def word_wrap( col_width=80 )
    self.dup.word_wrap!( col_width )
  end

  # As with #word_wrap, but modifies the string in place.
  #
  #   CREDIT: Gavin Kistner
  #   CREDIT: Dayne Broderson
  #
  def word_wrap!( col_width=80 )
    self.gsub!( /(\S{#{col_width}})(?=\S)/, '\1 ' )
    self.gsub!( /(.{1,#{col_width}})(?:\s+|$)/, "\\1\n" )
    self
  end

end
