
class ManyMethods

  puts "Generating methods..."

  (0..100000).each do |i|
    define_method( "_#{i}" ) { puts "Called method #{i}." }
  end

end

mm = ManyMethods.new

n1 = Time.now
mm._50000
n2 = Time.now
puts "Time to call a single method among 100000: #{(n2 - n1).to_f} seconds."
