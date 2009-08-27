require "facets/enumerator"

class String

  # Returns an Enumerator for iterating over each
  # line of the string, stripped of whitespace on
  # either side.
  #
  def cleanlines(&block)
    if block
      scan(/^.*?$/) do |line|
        block.call(line.strip)
      end
    else
      Enumerator.new(self) do |output|
        scan(/^.*?$/) do |line|
          output.yield(line.strip)
        end
      end
    end
  end

end

=begin test

  "a \n b \n c".newlines.class.must == Enumerator
  "a \n b \n c".newlines.to_a.must == %w{a b c}

  a = []
  "a \n b \n c".newlines{|nl| a << nl}
  a.must == %w{a b c}

=end

