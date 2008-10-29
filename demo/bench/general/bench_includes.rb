
$n = 100

puts "Generating #{$n} cascading modules..."

$m = []
(1..$n).each { |i|
  $m[i] = Module.new
  $m[i].class_eval {
    define_method( "_#{i}" ) { puts "Called method in module #{i}." }
    include $m[i-1] if $m[i-1]
  }
}

class ManyIncludes
  include $m[$n]
end

mm = ManyIncludes.new
mn = "_#{$n/2}"

t0 = Time.now
mm.send(mn)
t1 = Time.now
puts "Time to call a single method among #{$n} modules: #{(t1 - t0).to_f} seconds."
