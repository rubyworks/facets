class String

  # Treats +self+ and +path+ as representations
  # of pathnames, joining thme together as a
  # single path.
  #
  #   ('home' / 'trans')  #=> 'home/trans'
  #
  def /(path)
    File.join(self, path.to_s)
  end

end

