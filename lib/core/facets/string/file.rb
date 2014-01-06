require 'facets/functor'

class String

  # TODO: Should String#file be moved to functor gem?"

  # Use fluent notation for making file directives.
  #
  # For instance, if we had a file 'foo.txt',
  #
  #    'foo.txt'.file.mtime
  #
  def file
    f = self
    Functor.new do |op, *a, &b|
      File.send(op, f, *a, &b)
    end
  end

end

