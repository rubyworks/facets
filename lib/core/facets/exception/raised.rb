class Exception

  # Does a block raise an a given +exception+.
  #
  def self.raised? #:yeild:
    begin
      yield
      false
    rescue self
      true
    end
  end

end
