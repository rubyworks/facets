# TomsLib - Tom's Ruby Support Library
# Copyright (c) 2002 Thomas Sawyer, LGPL
#
# About
# A plethora of modules, mixins and methods. Have fun!

# TomsLib is free software; you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# TomsLib is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with TomsLib; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA


module TomsLib
  
  TITLE = "TomsLib"
	RELEASE = "02.06.18"
	STATUS = "UCC"
	AUTHOR = "Thomas Sawyer"
	EMAIL = "transami@transami.net"
  
	Package = "#{TITLE}"
	Version = "v#{RELEASE} #{STATUS}"
	Copyright = "Copyright © 2002 #{AUTHOR}, #{EMAIL}"

  def self.about
    puts
    puts TomsLib::Package
    puts TomsLib::Version
    puts TomsLib::Copyright
    puts
  end

end

# Write about info to standerd out
if $0 == __FILE__
	TomsLib.about
end