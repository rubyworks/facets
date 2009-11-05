class Object
  # Get or set state of object.
  #
  # TODO: Would #instance_state be a more appropriate name?
  def object_state(data=nil)
    if data
      instance_variables.each do |iv|
        name = iv.to_s.sub(/^[@]/, '').to_sym
        instance_variable_set(iv, snap[name])
      end
    else
      data = {}
      instance_variables.each do |iv|
        name = iv.to_s.sub(/^[@]/, '').to_sym
        data[name] = instance_variable_get(iv)
      end
      data
    end
  end

  # Replace state of object.
  def replace(data)
    instance_variables.each do |iv|
      name = iv.to_s.sub(/^[@]/, '').to_sym
      instance_variable_set(iv, data[name])
    end
  end
end

class Array
  def object_state(data=nil)
    data ? replace(data) : dup
  end
end

class String
  def object_state(data=nil)
    data ? replace(data) : dup
  end
end

class Hash
  def object_state(data=nil)
    data ? replace(data) : dup
  end
end

class Struct
  def object_state(data=nil)
    if data
      data.each_pair {|k,v| send(k.to_s + "=", v)}
    else
      data = {}
      each_pair{|k,v| data[k] = v}
      data
    end
  end

  def replace(snap)
    snap.each_pair {|k,v| send(k.to_s + "=", v)}
  end
end

