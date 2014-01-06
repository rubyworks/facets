require 'facets/functor'

class String

  # Use fluent notation for making file directives.
  #
  # For instance, if we had a file 'foo.txt',
  #
  #    'foo.txt'.file.mtime
  #
  def file
    #warn "Deprecation Warning: String#file is moved to hightops gem."
    f = self
    Functor.new do |op, *a, &b|
      File.send(op, f, *a, &b)
    end
  end

end

