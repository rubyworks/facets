class String

  # Unfold paragraphs such that new lines are removed from between
  # sentences of the same paragraph.
  #
  # Note that #rstrip is called on the final result, but this may
  # change in the future.
  #
  # FIXME: Sometimes adds one too many blank lines, which is why we are
  #         using rstrip. Fix and probably remove the rstrip.
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
