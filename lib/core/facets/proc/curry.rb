class Proc

  # Curry Proc object into new Proc object.
  #
  # TODO: Utilize Ruby 1.9's #curry method.

  def curry(*args)
    if args.empty?
      idx = (0...arity).to_a
    else
      raise ArgumentError, "argument count is greater than arity (#{args.size} > #{arity})" if args.size > arity
      raise ArgumentError, "arguments must be unique indexes" if args.uniq != args
      raise ArgumentError, "arguments must be indexes" if args.any?{ |a| !Fixnum===a }
      idx = (0...arity).to_a
      idx = args + (idx - args)  
    end

    rec = ''
    idx.each do |i|
      rec << "proc { |a#{i}| "
    end
    rec << "self["
    rec << (0...arity).to_a.collect{|i| "a#{i}"}.join(',')
    rec << "]"
    rec << "}" * arity

    instance_eval rec
  end

end

