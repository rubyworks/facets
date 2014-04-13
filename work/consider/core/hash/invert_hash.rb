# ==============================================================================
# EXTENDING CLASS HASH
# ==============================================================================
#
# (C) Copyright 2004 by Tilo Sloboda <tools@unixgods.org>
#
# updated:  Time-stamp: <Mon 06-Dec-2004 14:03:33 Tilo Sloboda>
#
# License:
#         Freely available under the terms of the OpenSource "Artistic License"
#         in combination with the Addendum A (below)
#
#         In case you did not get a copy of the license along with the software,
#         it is also available at:   http://www.unixgods.org/~tilo/artistic-license.html
#
# Addendum A:
#         THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU!
#         SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
#         REPAIR OR CORRECTION.
#
#         IN NO EVENT WILL THE COPYRIGHT HOLDERS  BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL,
#         SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY
#         TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED
#         INACCURATE OR USELESS OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM
#         TO OPERATE WITH ANY OTHER PROGRAMS), EVEN IF THE COPYRIGHT HOLDERS OR OTHER PARTY HAS BEEN
#         ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

# ==============================================================================
#
# Homepage:  http://www.unixgods.org/~tilo/Ruby/invert_hash.html
#
#
# Ruby's Hash.invert method leaves a lot to wish for..  it can't handle the  
# common case that two or more hash entries point to the same value..
#
# e.g.:
#   h =  {"uno"=>1, "tres"=>3, "three"=>3, "zwei"=>2, "two"=>2, "eins"=>1, "un"=>1, "deux"=>2, "one"=>1, "drei"=>3, "dos"=>2, "trois"=>3}
#   h.invert
#   => {1=>"one", 2=>"dos", 3=>"trois"}
#
#   the above result IS SIMPLY WRONG!
#
#   h.invert.invert
#   => {"one"=>1, "dos"=>2, "trois"=>3}
#
#   h.invert.invert == h
#   => false
#
#   Let's conclude that Ruby's built-in Hash.invert method is REALLY BROKEN!
#
#  
#   OK, let's try this new inverse method:
#
#   require 'invert_hash'
#
#   h.inverse
#   => {1=>["one", "un", "eins", "uno"], 2=>["dos", "deux", "two", "zwei"], 3=>["trois", "drei", "three", "tres"]}
#
#   h.inverse.inverse
#   => {"uno"=>1, "tres"=>3, "three"=>3, "zwei"=>2, "two"=>2, "eins"=>1, "un"=>1, "deux"=>2, "one"=>1, "drei"=>3, "dos"=>2, "trois"=>3}
#
#   h.inverse.inverse == h
#   => true
#
#   Looks much better, doesn't it?



class Hash

    def inverse
      i = Hash.new
      self.each_pair{ |k,v|
          if (v.class == Array)
              v.each{ |x|
                if i.has_key?(x)
                   i[x] = [k,i[x]].flatten
                else
                   i[x] = k
                end
              }
          else
		if i.has_key?(v)
		   i[v] = [k,i[v]].flatten
		else
		   i[v] = k
		end
          end
      }
      return i
    end
    
end

# remove the next line, if you want to always override Hash.invert
__END__

# if you want to permanently overload Ruby's original invert method, you may want to do this:

class Hash
    alias old_invert invert
    
    def invert
       self.inverse
    end
end
