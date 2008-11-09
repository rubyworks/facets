=begin

Some speed comparisions between ways to call a method.

=end

require 'benchmark'

$n = 50000

# standard array

def callme ; 1 ; end

$m = self.class.instance_method(:callme)


def call_normal
  $n.times do
    callme
  end
end

def call_by_send_symbol
  $n.times do
    send(:callme)
  end
end

def call_by_send_string
  $n.times do
    send("callme")
  end
end

def call_by_eval
  $n.times do
    eval "callme"
  end
end

def call_by_instance_eval
  $n.times do
    instance_eval { callme }
  end
end

def call_by_bind
  $n.times do
    $m.bind(self).call
  end
end

def call_inst_eval_send
  $n.times do
    $m.instance_eval { send(:callme) }
  end
end

### --- bench ---

puts "\nCURRENT"
Benchmark.bm(15) do |b|
  b.report("normal          :") { call_normal }
  b.report("send_symbol     :") { call_by_send_symbol }
  b.report("send_string     :") { call_by_send_string }
  b.report("bind            :") { call_by_bind }
  b.report("instance_eval   :") { call_by_instance_eval }
  b.report("by_eval         :") { call_by_eval }
  b.report("inst_eval_send  :") { call_inst_eval_send }
end



