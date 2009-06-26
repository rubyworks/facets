module Kernel

  def state(data=nil)
    if state
      instance_variables.each do |iv|
        name = iv.to_s.sub(/^[@]/, '').to_sym
        instance_variable_set(iv, data[name])
      end
    else
      data = Hash.new
      instance_variables.each do |iv|
        name = iv.to_s.sub(/^[@]/, '').to_sym
        data[name] = instance_variable_get(iv)
      end
      data
    end
  end

end

class Array
  def state(data=nil)
    data ? replace(data) : dup
  end
end

class String
  def state(data=nil)
    data ? replace(data) : dup
  end
end

class Hash
  def state(data=nil)
    data ? replace(data) : dup
  end
end

class Struct
  def state(data=nil)
    if data
      data.each_pair {|k,v| send(k.to_s + "=", v)}
    else
      data = Hash.new
      each_pair{|k,v| data[k] = v}
      data
    end
  end
end

