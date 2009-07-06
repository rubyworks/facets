class Proc

  # Curry Proc object into new Proc object.
  #
  # TODO: Utilize Ruby 1.9's #curry method.

  def curry(*args)
    Proc.make_curry(self, args)
  end
  
  def self.make_curry(prok, args = [])
    if args.empty?
      idx = (0...prok.arity).to_a
    else
      raise ArgumentError, "argument count is greater than prok.arity (#{args.size} > #{prok.arity})" if args.size > prok.arity
      raise ArgumentError, "arguments must be unique indexes" if args.uniq != args
      raise ArgumentError, "arguments must be indexes" if args.any?{ |a| !Fixnum===a }
      idx = (0...prok.arity).to_a
      idx = args + (idx - args)  
    end
    
    rec = ''
    idx.each do |i|
      rec << "proc { |a#{i}| "
    end
    rec << "prok["
    rec << (0...prok.arity).to_a.collect{|i| "a#{i}"}.join(',')
    rec << "]"
    rec << "}" * prok.arity
    
    instance_eval rec
    
  end

end

