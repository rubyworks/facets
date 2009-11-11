# encoding: us-ascii
#
#-----------------------------------------------------------
# INI File Parser
#
# Version: 0.1
# License: Public Domain
# Author: Dice <tetradice@gmail.com>
#-----------------------------------------------------------

module Ini
	VERSION = '0.1'
	VERSION_NUMBER = 0.1

	def self.parse(text, filename = self.to_s)
		re = {}
		current_section = nil
		
		text.each_with_index do |line, index|
			case line.chomp
			when /^\;/, /^\s*$/
				# skip (primary)
			when /^\[(.+)\]/
				# section start
				current_section = $1
				if re[current_section] then
					self.warn(filename, index+1, "section '#{$1}' overlap")
				else
					re[current_section] = {}
				end
				
			when /^(.+?)\s*=\s*(.*)$/
				# key and value
				if current_section then
					if re[current_section][$1] then
						self.warn(filename, index+1, "key '#{$1}' overlap")
					end
					
					re[current_section][$1] = $2
				else
					self.warn(filename, index+1, "'#{$1}' is not in section")
				end
			else
				self.warn(filename, index+1, "warning: unknown statement")
			end
		end
		
		re
	end
	
	def self.parse_file(path)
		self.parse(File.read(path), path.to_s)
	end
	
	def self.warn(filename, lineno, msg)
		if $VERBOSE or $DEBUG then
			$stderr.puts "#{filename}:#{lineno}: warning: #{msg}"
		end
	end
end


INI = Ini