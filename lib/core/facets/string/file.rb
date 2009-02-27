require 'facets/functor'

class String

  # Use fluent notation for making file directives.
  #
  #    '~/trans/Desktop/notes.txt'.file.mtime
  #  
  def file
    f = self
    Functor.new do |op, *a|
      File.send(op, f, *a)
    end
  end

end

