require 'thread'

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
   # Default method to to create a key to cache already constructed
   # instances. In the use case MultitonClass.new(e), MultiClass.new(f)
   # must be semantically equal if multiton_id(e).eql?(multiton_id(f))
   # evaluates to true.
   e
 end

 def initialize_copy(orig)
   super
   @multiton_instance= Hash.new
   @multiton_mutex= InstanceMutex.new
 end

 def inherited(sub)
   super
   sub.instance_eval do
     @multiton_instance = Hash.new
     @multiton_mutex= InstanceMutex.new
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

 def singleton_method_added(sym)
   super
   if (sym == :marshal_dump) & singleton_methods.include?('marshal_dump')
     raise TypeError, "Don't use marshal_dump - rely on _dump and _load instead"
   end
 end

 def self.extended(klass)
   klass.instance_eval do
     @multiton_instance = Hash.new
     @multiton_mutex = InstanceMutex.new
     if singleton_methods.include?(:marshal_dump)
       class << self; undef marshal_dump end
       warn "warning: marshal_dump was undefined since it is incompatible with the Multiton pattern"
     end
   end
 end

 private_class_method :extended
end





if $0 == __FILE__

  ### Simple marshalling test #######
  class A
    def initialize(a,*e)
      @e = a
    end

    include Multiton
    begin
      def self.marshal_dump(depth = -1)
      end
    rescue => mes
      p mes
      class << self; undef marshal_dump end
    end
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


  require 'benchmark'
  include Benchmark

  bmbm do |x|
    x.report('Initialize 465 SymPlane instances') { SymPlane.run(30) }
    x.report('Reinitialize ') do
      sleep 3
      SymPlane.reinitialize
    end
  end

end
