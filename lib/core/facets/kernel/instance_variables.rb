module Kernel

  def instance_vars
    InstanceVariables.new(self)
  end

end


class InstanceVariables

  include Enumerable

  def initialize(delegate)
    @delegate = delegate
  end

  def instance_delegate
    @delegate
  end

  def each
    @delegate.instance_variables.each do |name|
      yield(name[1..-1].to_sym, @delegate.instance_variable_get(name))
    end
  end

  def to_hash
    h = {}
    each do |name, value|
      h[name] = value
    end
    h
  end

  def [](name)
    name = atize(name)
    @delegate.instance_variable_get(name)
  end

  def []=(name, value)
    name = atize(name)
    @delegate.instance_varaible_set(name,value)
  end

  def <<(pair)
    name, value = *pair
    name = atize(name)
    @delegate.instance_varaible_set(name, value)
  end

  def update(hash)
    hash.each do |pair|
      self << pair
    end
  end

  def keys
    @delegate.instance_variables.collect do |name|
      name[1..-1].to_sym
    end
  end

  def names
    @delegate.instance_variables.collect do |name|
      name[1..-1]
    end
  end

  def values
    @delegate.instance_variables.collect do |name|
      @delegate.instance_variable_get(name)
    end
  end

  private

    def atize(name)
      name !~ /^@/ ? "@#{name}" : name
    end

end


if $0 == __FILE__

  class Friend
    attr_accessor :name, :age, :phone
    def initialize(name, age, phone)
      @name, @age, @phone = name, age, phone
    end
  end

  f1 = Friend.new("John", 30, "555-1212")
  p f1.variables
  p f1.variables.to_hash

end

