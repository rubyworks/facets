class NilClass

  unless defined? to_f

    # Allows <tt>nil</tt> to respond to #to_f.
    # Always returns <tt>0</tt>.
    #
    #   nil.to_f   #=> 0.0
    #
    #   CREDIT: Matz

    def to_f; 0.0; end

  end

end

