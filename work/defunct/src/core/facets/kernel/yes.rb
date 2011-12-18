require 'facets/kernel/ask'

module Kernel

  # Ask a question expecting a yes answer.
  def yes?(question)
    case ask(question).downcase
    when 'y', 'yes'
      true
    else
      false
    end
  end

  # Ask a question expecting a no answer.
  def no?(question)
    case ask(question).downcase
    when 'n', 'no'
      true
    else
      false
    end
  end

end
