class String

  # Unfold paragrpahs.
  #
  # FIXME: Sometimes adds one too many blank lines. TEST!!!
  #
  def unfold
    blank = false
    text  = ''
    split(/\n/).each do |line|
      if /\S/ !~ line
        text << "\n\n"
        blank = true
      else
        if /^(\s+|[*])/ =~ line
          text << (line.rstrip + "\n")
        else
          text << (line.rstrip + " ")
        end
        blank = false
      end
    end
    text = text.gsub(/(\n){3,}/,"\n\n")
    text.rstrip
  end

end
