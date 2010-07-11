class Object
  # Get or set state of object.
  #
  #   class StateExample
  #     attr_reader :a, :b
  #     def initialize(a,b)
  #       @a, @b = a, b
  #     end
  #   end
  #
  #   obj = StateExample.new(1,2)
  #   obj.a  #=> 1
  #   obj.b  #=> 2
  #
  #   obj.object_state(:a=>3, :b=>4)
  #   obj.a  #=> 3
  #   obj.b  #=> 4
  #
  # TODO: Would #instance_state be a more appropriate name?
  #
  # TODO: Consider how this relates to #instance.
  def object_state(data=nil)
    if data
      instance_variables.each do |iv|
        name = iv.to_s.sub(/^[@]/, '').to_sym
        instance_variable_set(iv, data[name])
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

  def replace(data)
    data.each_pair {|k,v| send(k.to_s + "=", v)}
  end
end

