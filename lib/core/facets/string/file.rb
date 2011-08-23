require 'facets/functor'

class String

  # Use fluent notation for making file directives.
  #
  # For instance, if we had a file 'foo.txt',
  #
  #    'foo.txt'.file.mtime
  #
  def file
    Functor.new(&method(:file_send).to_proc)
  end

  private

  def file_send(op, *a, &b)
    File.send(op, self, *a, &b)
  end

  ## TODO: When no longer needing to support 1.8.6 we can use:
  ##
  ## # Use fluent notation for making file directives.
  ## #
  ## #    'README.rdoc'.file.mtime
  ## #  
  ## def file
  ##   f = self
  ##   Functor.new do |op, *a, &b|
  ##     File.send(op, f, *a, &b)
  ##   end
  ## end

end

