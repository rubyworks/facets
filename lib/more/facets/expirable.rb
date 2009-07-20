# Expirable
#
# Copyright (c) 2004 George Moschovitis
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Generic expirability mixin.
#
module Expirable

  attr_accessor :expires

  # Set the expires timeout for this entry.

  def expires_after(timeout = (60*60*24))
    @expires = Time.now + timeout
  end

  # Set the expire timeout for this entry. The timeout happens
  # after (base + rand(spread)) seconds.

  def expires_spread(base, spread)
    @expires = Time.now + base + rand(spread)
  end

  # Is this entry expired?

  def expired?
    if @expires.nil? or (Time.now > @expires)
      return true
    else
      return false
    end
  end

  # Update the expiration period. Override in your application.

  def touch!
  end

end

