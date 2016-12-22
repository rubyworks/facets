
module Enumerable
	class Position
		def initialize
			@first = true
			@last = false
		end
		
		def after_first!
			@first = false
		end
		
		def at_end!
			@last = true
		end
		
		def first?
			@first
		end
		
		def middle?
			not (@first or @last)
		end
		
		def last?
			@last
		end
	end
	
	# Allows one to know the position of the enumeration easily.
	#
	#    5.times.collect.with_position do |i, position|
	#        $stdout.write "#{i}#{position.middle? ? ',' : ''}"
	#    end
	#
	# Where this becomes more useful, is when it's easy to determine the position of elements, e.g.
	#
	#    10.times.select(&:odd?).with_position{|n,p| ... }
	#
	def with_position
		return to_enum(:with_position) unless block_given?
		
		position = Position.new
		
		while item = self.next
			begin
				self.peek
			rescue StopIteration
				position.at_end!
			end
			
			yield item, position.dup
			
			position.after_first!
		end
	rescue StopIteration
	end
end
