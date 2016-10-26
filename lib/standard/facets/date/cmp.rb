
require 'date'

class Time
	alias_method :old_compare, :<=>
	private :old_compare
	
	# Allow for Date <=> DateTime <=> Time, to work as expected.
	
	def <=>(other)
		if Date === other or DateTime === other
			self.to_datetime <=> other
		else
			old_compare(other)
		end
	end
end

class Date
	alias_method :old_compare, :<=>
	private :old_compare
	
	# Allow for Date <=> DateTime <=> Time, to work as expected.
	
	def <=>(other)
		if Time === other
			self.to_datetime <=> other.to_datetime
		else
			old_compare(other)
		end
	end
end
