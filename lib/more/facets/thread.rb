# = Thread Related Extensions
#
# Thread extensions, in particular for Enumerable --send
# a message to each member via a thread and collect the results.
#
# == Authors
#
# * Sean O'Halpin
#
# == Todo
#
# * Better names for these methods ?
#
# == Copying
#
# Copyright (c) 2006 Sean O'Halpin
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'thread'
require 'facets/enumerable/map_send'

module Enumerable

  # Like Enumerable#map but each iteration is processed via
  # a separate thread.
  #
  #  CREDIT Sean O'Halpin

  def threaded_map #:yield:
    map{ |e| Thread.new(e){ |t| yield(t) } }.map{ |t| t.value }
  end

  # Like Enumerable#map_send but each iteration is processed via
  # a separate thread.
  #
  #  CREDIT Sean O'Halpin

  def threaded_map_send(meth, *args, &block)
    map{ |e| Thread.new(e){ |t| t.send(meth, *args, &block) } }.map{ |t| t.value }
  end

end

