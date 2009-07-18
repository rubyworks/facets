# = Ruby Configuration Extensions
#
# An extended rendition of the Ruby's standard Config module.
#
# == Authors
#
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2006 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'rbconfig'

module Config

  def self.inspect
    CONFIG.inspect
  end

  # In case rubygems has already defined it.
  unless self.respond_to?(:datadir)
    # Return the path to the data directory associated with the
    # given library/package name. Normally this is just
    #
    #   "#{Config::CONFIG['datadir']}/#{name}"
    #
    # but may be modified by tools like RubyGems to handle
    # versioned data directories.

    def self.datadir(package_name)
      File.join(CONFIG['datadir'], package_name)
    end
  end

end
