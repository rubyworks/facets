require "facets/enumerator"

class String

  # Returns an Enumerator for iterating over each
  # line of the string, void of the termining newline
  # character, in contrast to #lines which retains it.
  #
  def newlines(&block)
    if block
      scan(/^.*?$/) do |line|
        block.call(line.chomp)
      end
    else
      Enumerator.new(self) do |output|
        scan(/^.*?$/) do |line|
          output.yield(line.chomp)
        end
      end
    end
  end

end

=begin test

  "a\nb\nc".newlines.class.must == Enumerator
  "a\nb\nc".newlines.to_a.must == %w{a b c}

  a = []
  "a\nb\nc".newlines{|nl| a << nl}
  a.must == %w{a b c}

=end

