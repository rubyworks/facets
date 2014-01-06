require 'facets/functor'

class Hash

  # TODO: Change name of Hash#data to something better?
  
  # TODO: Is Hash#data really a method worth having?

  # TODO: Should Hash#data be moved to the Functor project?

  # Access to a hash as if it were an OpenStruct.
  #
  #   h = {:a=>1, :b=>2}
  #
  #   h.data.a  #=> 1
  #   h.data.b  #=> 2
  #   h.data.c  #=> nil
  #
  #   h.data.c = 3
  #   h.data.c  #=> 3
  #
  #   h.data.a?  #=> true
  #   h.data.d?  #=> false
  #
  def data
    this = self
    Functor.new do |op, *a|
      case op.to_s
      when /\=$/
        op = op.to_s.chomp('=')
        this[op] = a.first
      when /\?$/
        op = op.to_s.chomp('?')
        this.key?(op.to_s) || this.key?(op.to_sym)
      when /\!$/
        op = op.to_s.chomp('!')
        this[op] # ???
      else
        this[op.to_s] || this[op.to_sym]
      end
    end
  end

end
