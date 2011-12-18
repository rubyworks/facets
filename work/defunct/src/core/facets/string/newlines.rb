require "facets/enumerator"

class String

  # Returns an Enumerator for iterating over each
  # line of the string, void of the termining newline
  # character, in contrast to #lines which retains it.
  #
  #   "a\nb\nc".newlines.class.assert == Enumerator
  #   "a\nb\nc".newlines.to_a.assert == %w{a b c}
  #
  #   a = []
  #   "a\nb\nc".newlines{|nl| a << nl}
  #   a.assert == %w{a b c}
  #
  def newlines(&block)
    if block
      scan(/^.*?$/) do |line|
        block.call(line.chomp)
      end
    else
      str = self
      Enumerator.new do |output|
        str.scan(/^.*?$/) do |line|
          output.yield(line.chomp)
        end
      end
    end
  end

end

