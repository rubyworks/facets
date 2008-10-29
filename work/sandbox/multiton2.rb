
module Multiton

  #  disable build-in copying methods
  def clone
    raise TypeError, "can't clone Multiton #{self}"
  end

  def dup
    raise TypeError, "can't dup Multiton #{self}"
  end

  protected  #  default marshalling strategy
  def _dump(depth=-1)
    Marshal.dump(@multiton_initializer)
  end

  #

  class << self
    private
    def append_features(mod)
      #  help out people counting on transitive mixins
      unless mod.instance_of?(Class)
        raise TypeError, "Inclusion of Multiton in module #{mod}"
      end
      super
    end

    def included(klass)
      # gracefully handle multiple inclusions of Multiton
      unless class << klass; include?(Multiton::ClassMethods) end
        klass.private_class_method  :new, :allocate
        klass.extend Multiton::ClassMethods
      end
    end
  end

  #

  module ClassMethods

    def instance(*e)
      arg = multiton_id(e)
      @multiton_instance.fetch(arg) do
        @multiton_mutex[arg].synchronize do
          @multiton_instance.fetch(arg) do
            val = @multiton_instance[arg] = new(*e)
            val.instance_variable_set(:@multiton_initializer,e)
            @multiton_mutex.initialized(arg)
            val
          end
        end
      end
    end

    def initialized?(*e)
      @multiton_instance.key?(multiton_id(e))
    end

    protected
    def reinitialize
      @multiton_instance.clear
      @multiton_mutex.clear
    end

    def _load(str)
      instance(*Marshal.load(str))
    end

    private
    def multiton_id(e)
      e
    end

    def initialize_copy(orig)
      super
      Multiton::ClassMethods.extended(self)
    end

    def inherited(sub)
      super
      Multiton::ClassMethods.extended(sub)
    end

    class << self
      protected
      def extended(klass)
        klass.class_eval do
          @multiton_instance = Hash.new
          @multiton_mutex = InstanceMutex.new

          private
          # Defining  marshal_dump & marshal_load instance methods introduces
          # a loop hole to create additonal instances. Providing a private
          # marshal_dump method forces Ruby to fall back on the _dump & _load
          # marshalling scheme. When $VERBOSE == true issue a method re-
          # definition warning for (re)defining marshal_dump.
          def marshal_dump(depth = -1)
            raise TypeError, "don't use marshal_load + marshal_dump marshalling"
          end
        end
      end

      class InstanceMutex < Hash
        def initialize
          @global = Mutex.new
        end

        def initialized(arg)
          store(arg,DummyMutex)
        end

        def (DummyMutex = Object.new).synchronize
          yield
        end

        def default(arg)
          @global.synchronize { fetch(arg) { store(arg,Mutex.new) }}
        end
      end
    end
  end
end


























module Multiton
  #  disable build-in copying methods
  def clone
    raise TypeError, "can't clone Multiton #{self}"
  end

  def dup
    raise TypeError, "can't dup Multiton #{self}"
  end

  protected  #  default marshalling strategy
  def _dump(depth=-1)
    Marshal.dump(@multiton_initializer)
  end
end

class << Multiton
  private
  def append_features(mod)
    #  help out people counting on transitive mixins
    unless mod.instance_of?(Class)
      raise TypeError, "Inclusion of Multiton in module #{mod}"
    end
    super
  end

  def included(klass)
    # gracefully handle multiple inclusions of Multiton
    unless class << klass; include?(Multiton::ClassMethods) end
      klass.private_class_method  :new,:allocate
      klass.extend Multiton::ClassMethods
    end
  end
end

module Multiton::ClassMethods
  def instance(*e)
    arg = multiton_id(e)
    @multiton_instance.fetch(arg) {
      @multiton_mutex[arg].synchronize {
        @multiton_instance.fetch(arg) {
          val = @multiton_instance[arg] = new(*e)
          val.instance_variable_set(:@multiton_initializer,e)
          @multiton_mutex.initialized(arg)
          val
    }}}
  end

  def initialized?(*e)
    @multiton_instance.key?(multiton_id(e))
  end

  protected
  def reinitialize
    @multiton_instance.clear
    @multiton_mutex.clear
  end

  def _load(str)
    instance(*Marshal.load(str))
  end

  private
  def multiton_id(e)
    e
  end

  def initialize_copy(orig)
    super
    Multiton::ClassMethods.extended(self)
  end

  def inherited(sub)
    super
    Multiton::ClassMethods.extended(sub)
  end
end

class << Multiton::ClassMethods
  protected
  def extended(klass)
    klass.class_eval do
      @multiton_instance = Hash.new
      @multiton_mutex = InstanceMutex.new

      private
      # Defining  marshal_dump & marshal_load instance methods introduces
      # a loop hole to create additonal instances. Providing a private
      # marshal_dump method forces Ruby to fall back on the _dump & _load
      # marshalling scheme. When $VERBOSE == true issue a method re-
      # definition warning for (re)defining marshal_dump.
      def marshal_dump(depth = -1)
        raise TypeError, "don't use marshal_load + marshal_dump marshalling"
      end
    end
  end

  class InstanceMutex < Hash
    def initialize
      @global = Mutex.new
    end

    def initialized(arg)
      store(arg,DummyMutex)
    end

    def (DummyMutex = Object.new).synchronize
      yield
    end

    def default(arg)
      @global.synchronize { fetch(arg) { store(arg,Mutex.new) }}
    end
  end
end




### Simple marshalling test #######
class A
  def initialize(a,*e)
    @e = a
  end

  include Multiton

end




C = Class.new(A.clone)
s = C.instance('a','b')

raise unless Marshal.load(Marshal.dump(s)) == s


### Interdependent initialization example and threading benchmark ###

class Regular_SymPlane
  def self.multiton_id(e)
      a,b = e
      (a+b - 1)*(a+b )/2  + (a > b ? a : b)
  end

  def initialize(a,b)
    klass = self.class
    if a < b
      @l =  b > 0 ?  klass.instance(a,b-1) : nil
      @r =  a > 0 ?  klass.instance(a-1,b) : nil
    else
      @l =  a > 0 ?  klass.instance(a-1,b) : nil
      @r =  b > 0 ?  klass.instance(a,b-1) : nil
    end
  end

  include Multiton
end



def nap
  # Thread.pass
  sleep(rand(0.01))
end

class SymPlane < Regular_SymPlane
  @m = Mutex.new
  @count = 0
end

class << SymPlane
  attr_reader :count
  def reinitialize
    super
    @m = Mutex.new
    @count = 0
  end
  def inherited(sub_class)
    super
    sub_class.instance_eval { @m = Mutex.new; @count = 0 }
  end

  def multiton_id(e)
    nap()
    super
  end

  def new(*e)
    super
  ensure
    nap()
    @m.synchronize { p @count if (@count += 1) % 15 == 0 }
  end

  def run(k)
    threads = 0
    max = k * (k+1) / 2
    puts ""
    while count() < max
      Thread.new { threads+= 1; instance(rand(30),rand(30)) }
    end
    puts "\nThe simulation created #{threads} threads"
  end
end


require 'Benchmark'
include Benchmark

bmbm do |x|
  x.report('Initialize 465 SymPlane instances') { SymPlane.run(30) }
  x.report('Reinitialize ') do
    sleep 3
    SymPlane.reinitialize
  end
end

















module Multiton
  #  disable build-in copying methods
  def clone
    raise TypeError, "can't clone Multiton #{self}"
  end

  def dup
    raise TypeError, "can't dup Multiton #{self}"
  end

  protected  #  default marshalling strategy
  def _dump(depth=-1)
    Marshal.dump(@multiton_initializer)
  end
end

class << Multiton
  private
  def append_features(mod)
    #  help out people counting on transitive mixins
    unless mod.instance_of?(Class)
      raise TypeError, "Inclusion of Multiton in module #{mod}"
    end
    super
  end

  def included(klass)
    # gracefully handle multiple inclusions of Multiton
    unless class << klass; include?(Multiton::ClassMethods) end
      klass.private_class_method  :new, :allocate
      klass.extend Multiton::ClassMethods
    end
  end
end


module Multiton::ClassMethods
  class SyncHash < Hash
    def initialize
      @global = Mutex.new
      super {|a,b| @global.synchronize {|| fetch(b) {|| a[b]= yield }}}
    end
  end

  PoolInstance = SyncHash.new{ Hash.new }
  PoolInstanceMutex = SyncHash.new{ SyncHash.new{ Mutex.new }}
  def (DummyMutex = Object.new).synchronize
    yield
  end

  def instance(*e)
    arg = multiton_id(e)
    (@multiton_instance ||= PoolInstance[self]).fetch(arg) {
      (@multiton_mutex ||= PoolInstanceMutex[self])[arg].synchronize {
        @multiton_instance.fetch(arg) {
          val = @multiton_instance[arg] = new(*e)
          val.instance_variable_set(:@multiton_initializer,e)
          @multiton_mutex[arg]= DummyMutex
          val
    }}}
  end

  def initialized?(*e)
    # the method is not thread safe ...
    (@multiton_instance ||= PoolInstance[self]).key?(multiton_id(e))
  end

  protected
  def reinitialize
    (@multiton_instance ||= PoolInstance[self]).clear
    (@multiton_mutex ||= PoolInstanceMutex[self]).clear
  end

  def _load(str)
    instance(*Marshal.load(str))
  end

  private
  def multiton_id(e)
    e
  end

  # Defining  marshal_dump & marshal_load instance methods introduces
  # a loop hole to create additonal instances. Providing a private
  # marshal_dump method forces Ruby to fall back on the _dump & _load
  # marshalling scheme. When $VERBOSE == true issue a method re-
  # definition warning for (re)defining marshal_dump.
  def self.extended(klass)
    klass.class_eval do
      private
      def marshal_dump(depth = -1)
        raise TypeError, "don't use marshal_load + marshal_dump marshalling"
      end
    end
  end
  private_class_method :extended

end








### Simple marshalling test #######
class A
  def initialize(a,*e)
    @e = a
  end

  include Multiton

end




C = Class.new(A.clone)
s = C.instance('a','b')

raise unless Marshal.load(Marshal.dump(s)) == s


### Interdependent initialization example and threading benchmark ###

class Regular_SymPlane
  def self.multiton_id(e)
      a,b = e
      (a+b - 1)*(a+b )/2  + (a > b ? a : b)
  end

  def initialize(a,b)
    klass = self.class
    if a < b
      @l =  b > 0 ?  klass.instance(a,b-1) : nil
      @r =  a > 0 ?  klass.instance(a-1,b) : nil
    else
      @l =  a > 0 ?  klass.instance(a-1,b) : nil
      @r =  b > 0 ?  klass.instance(a,b-1) : nil
    end
  end

  include Multiton
end



def nap
  # Thread.pass
  sleep(rand(0.01))
end

class SymPlane < Regular_SymPlane
  @m = Mutex.new
  @count = 0
end

class << SymPlane
  attr_reader :count
  def reinitialize
    super
    @m = Mutex.new
    @count = 0
  end
  def inherited(sub_class)
    super
    sub_class.instance_eval { @m = Mutex.new; @count = 0 }
  end

  def multiton_id(e)
    nap()
    super
  end

  def new(*e)
    super
  ensure
    nap()
    @m.synchronize { p @count if (@count += 1) % 15 == 0 }
  end

  def run(k)
    threads = 0
    max = k * (k+1) / 2
    puts ""
    while count() < max
      Thread.new { threads+= 1; instance(rand(k),rand(k)) }
    end
    puts "\nThe simulation created #{threads} threads"
  end
end


require 'Benchmark'
include Benchmark

bmbm do |x|
  x.report('Initialize 465 SymPlane instances') { SymPlane.run(30) }
  x.report('Reinitialize ') do
    sleep 3
    SymPlane.reinitialize
  end
end