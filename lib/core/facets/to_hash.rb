class Array

  if RUBY_VERSION < '1.9'

    # Converts an associative array into a hash.
    #
    #   a = [ [:a,1], [:b,2] ]
    #   a.to_h  #=> { :a=>1, :b=>2 }
    #
    # If +arrayed+ is set it will maintain trailing arrays.
    #
    #   a = [ [:a,1,2], [:b,3] ]
    #   a.to_h(true)  #=> { :a=>[1,2], :b=>[3] }
    #
    # NOTE: The use of a +values+ parameter has been deprecated
    # because that functionality is as simple as:
    #
    #   array1.zip(array2).to_h
    #
    # CREDIT: Trans

    def to_h(arrayed=nil)
      if arrayed
        h = {}
        each{ |k,*v| h[k] = v }
      else
        ary = []
        each do |a|
          Array===a ? ary.concat(a) : ary << a
        end
        h = Hash[*ary]
      end
      h
    end

  else

    def to_h(arrayed=nil)
      if arrayed
        h={}
        each{ |k,*v| h[k] = v }
        h
      else
        Hash[*flatten(1)]
      end
    end

    # * Sander Suggested *
    #def to_h
    #  h = {}
    #  if(flatten.size % 2 == 1)
    #    each { |e| h[e.first] = e.slice(1..-1) }
    #  else
    #    h = Hash[*flatten(1)]
    #  end
    #  h
    #end

  end

  #def to_hash
  #  h = {}
  #  each_with_index do |v, i|
  #    h[i] = v
  #  end
  #  h
  #end

end

class Hash

  # Return a rehashing of _self_.
  #
  #   {"a"=>1,"b"=>2}.to_h  #=> {"b"=>2,"a"=>1}
  #
  # CREDIT: Forian Gross

  def to_h; rehash; end

end

module Enumerable

  # Convert an Enumerable object into a hash by first
  # turning it into an array.
  #
  # CREDIT: Trans

  def to_h(arrayed=nil)
    to_a.to_h(arrayed)
  end

  #def to_hash
  #  to_a.to_hash
  #end

end

class NilClass

  # Allows <tt>nil</tt> to create an empty hash,
  # similar to #to_a and #to_s.
  #
  #   nil.to_h    #=> {}
  #
  # CREDIT: Trans

  def to_h; {}; end

end

 
if RUBY_VERSION < "1.9.0"

  class Enumerable::Enumerator
  
    # Convert an Enumerable::Enumerator object directly into a hash.
    # 
    #   e = [1,2,3,4,5].to_enum
    #   e.to_h  #=> {5=>nil, 1=>2, 3=>4}
    #   e2 = [1,2,1,3,1,5].to_enum
    #   e2.to_h #=> {1=>5}
    #   e3 = [[1,:a],[2,:b],[3,:c]].to_enum
    #   e3.to_h #=> { 1=>:a, 2=>:b, 3=>:c }
    #
    # CREDIT: Sandor Szücs
    def to_h(arrayed=nil)
      h = {}
      loop do
        x,y = self.next
        h[x] ||= nil
        y = self.next unless y
        h[x] = y
      end

      return h
    end
  end

else

  class Enumerator
    
    # Convert an Enumerator object directly into a hash.
    # 
    #   e1 = [1,2,3,4,5].to_enum
    #   e1.to_h  #=> {5=>nil, 1=>2, 3=>4}
    #   e2 = [1,2,1,3,1,5].to_enum
    #   e2.to_h #=> {1=>5}
    #   e3 = [[1,:a],[2,:b],[3,:c]].to_enum
    #   e3.to_h #=> { 1=>:a, 2=>:b, 3=>:c }
    #
    # CREDIT: Sandor Szücs
    def to_h
      h = {}
      loop do
        x,y = self.next
        h[x] ||= nil
        y = self.next unless y
        h[x] = y
      end

      return h
    end

  end

end

