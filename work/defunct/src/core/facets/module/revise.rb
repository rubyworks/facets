require 'facets/module/redirect_method'
require 'facets/module/redefine_method'
require 'facets/module/rename_method'
require 'facets/module/wrap_method'
require 'facets/module/nodef'

class Module

  # Return a new module based on another. This includes the original module
  # into the new revised module.
  #
  #   module ReviseExample
  #     def foo; "foo"; end
  #   end
  #
  #   ReviseExample2 = ReviseExample.revise do
  #     alias_method :bar, :foo
  #   end
  #
  #   object = Object.new
  #   object.extend ReviseExample2
  #   object.bar  #=> 'foo'
  #
  # CREDIT: Trans

  def revise(&blk)
    base = self
    nm = Module.new{ include base }
    nm.class_eval(&blk)
    nm
  end

  alias_method :revisal, :revise
end

class Class
  undef_method :revise
  undef_method :revisal
end


