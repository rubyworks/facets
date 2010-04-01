module Kernel
  INSTANCES = {}

  # Returns an instance of Instance for +self+,
  # which allows convenient access to an object's
  # internals.

  def instance
    INSTANCES[self] ||= Instance.new(self)
  end

end

# = Instance Class
#
#   class Friend
#     attr_accessor :name, :age, :phone
#     def initialize(name, age, phone)
#       @name, @age, @phone = name, age, phone
#     end
#   end
#
#   f1 = Friend.new("John", 30, "555-1212")
#   p f1.instance
#   f1.instance.update({:name=>'Jerry'})
#   p f1.instance
#
class Instance

  include Enumerable

  #
  def initialize(delegate)
    @delegate = delegate
  end

  #
  def instance_delegate
    @delegate
  end

  #
  def each
    @delegate.instance_variables.each do |name|
      yield(name[1..-1].to_sym, @delegate.instance_variable_get(name))
    end
  end

  # Return instance variables with values as a hash.
  #
  #   class X
  #     def initialize(a,b)
  #       @a, @b = a, b
  #     end
  #   end
  #
  #   x = X.new(1,2)
  #
  #   x.instance.to_h  #=> { :a=>1, :b=>2 }
  #
  def to_h(at=false)
    h = {}
    if at
      @delegate.instance_variables.each do |name|
        h[name] = @delegate.instance_variable_get(name)
      end
    else
      each do |key, value|
        h[key] = value
      end
    end
    h
  end

  # TODO: Not sure if this should be used.
  alias_method :to_hash, :to_h

  #
  def [](name)
    name = atize(name)
    @delegate.instance_variable_get(name)
  end

  #
  def []=(name, value)
    name = atize(name)
    @delegate.instance_variable_set(name,value)
  end

  #
  def <<(pair)
    name, value = *pair
    name = atize(name)
    @delegate.instance_variable_set(name, value)
  end

  # Set instance variables given a +hash+.
  #
  #   instance.update('@a'=>1, '@b'=>2)
  #   @a   #=> 1
  #   @b   #=> 2
  #
  # Also, +@+ sign is not neccessary.
  #
  #   instance.update(:a=>1, :b=>2)
  #   @a   #=> 1
  #   @b   #=> 2
  #
  def update(hash)
    hash.each do |pair|
      self << pair
    end
  end

  # A hold-over from the the old #instance_assign method.
  alias_method :assign, :update

  # Same as #instance_variables.
  def variables
    @delegate.instance_variables
  end

  # Instance vairable names as symbols.
  def keys
    @delegate.instance_variables.collect do |name|
      name[1..-1].to_sym
    end
  end

  # Instance variable names as strings.
  def names
    @delegate.instance_variables.collect do |name|
      name[1..-1]
    end
  end

  # Instance variable values.
  def values
    @delegate.instance_variables.collect do |name|
      @delegate.instance_variable_get(name)
    end
  end

  # Instance evaluation.
  def eval(*a,&b)
    @delegate.instance_eval(*a,&b)
  end

  private

    def atize(name)
      name.to_s !~ /^@/ ? "@#{name}" : name
    end

end

