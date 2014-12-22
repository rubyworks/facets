
require 'enumerator'

# This could be used instead of Enumerator#x. It's more
# concise, but is it safe?

class Enumerable::Enumerator
  def method_missing(sym,*args,&blk)
    each{ |x| x.send(sym,*args,&blk) }
  end
end

