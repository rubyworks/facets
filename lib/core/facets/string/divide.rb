class String

  # Breaks a string up into an array based on a regular expression.
  # Similar to scan, but includes the matches.
  #
  #   s = "<p>This<b>is</b>a test.</p>"
  #   s.divide( /\<.*?\>/ )
  #
  # _produces_
  #
  #   ["<p>This", "<b>is", "</b>a test.", "</p>"]
  #
  #   CREDIT: Trans

  def divide( re )
    re2 = /#{re}.*?(?=#{re}|\Z)/
    scan(re2) #{re}(?=#{re})/)
  end

end

