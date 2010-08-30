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
      str = self
      Enumerator.new do |output|
        str.scan(/^.*?$/) do |line|
          output.yield(line.strip)
        end
      end
    end
  end

end

