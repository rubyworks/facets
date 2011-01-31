class Exception

  # Supress errors while executing a block, with execptions.
  #
  # CREDIT: David Heinemeier Hansson, Thomas Sawyer

  def self.suppress(*exception_classes)
    exception_classes.each do |e|
      unless e < self
        raise ArgumentError, "exception #{e} not a subclass of #{self}"
      end
    end
    exception_classes = [self] | exception_classes
    begin
      yield
    rescue Exception => e
      raise unless exception_classes.any? { |cls| e.kind_of?(cls) }
    end
  end

end

