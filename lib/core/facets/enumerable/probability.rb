module Enumerable

  # Generates a hash mapping each unique element in the array
  # to the relative frequency, i.e. the probablity, of
  # it appearence.
  #
  #   CREDIT: Brian Schröder

  def probability
    probs = Hash.new(0.0)
    size = 0.0
    each do | e |
      probs[e] += 1.0
      size += 1.0
    end
    probs.keys.each{ |e| probs[e] /= size }
    probs
  end

  # old def
  #
  #   def probability
  #     arr = self.to_a
  #     probHash = Hash.new
  #     size = arr.size.to_f
  #     arr.uniq.each do |i|
  #       ct = arr.inject(0) do |mem,obj|
  #         obj.eql?(i) ? (mem+1) : mem
  #       end
  #       probHash[i] = ct.to_f/size
  #     end
  #     probHash
  #   end

end

