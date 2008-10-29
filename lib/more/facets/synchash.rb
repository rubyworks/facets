# = SyncHash
#
# A thread-safe hash. We use a sync object instead of a mutex,
# because it is re-entrant. An exclusive lock is needed when
# writing, a shared lock IS NEEDED when reading.
#
# Uses the delegator pattern to allow for multiple
# implementations!
#
#   hash = SyncHash.new
#   hash = SyncHash.new(Hash.new)   # Delegates
#
# == Design
#
# This class uses the delegator pattern. However we don't use Ruby's
# delegation facilities, they are more general and powerful than we
# need here (and slower). Instead a custom (but simple) solution is
# used.
#
# == Authors
#
# * George Moschovitis
#
# == Copyright
#
# Copyright (c) 2004 George Moschovitis
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'sync'

# = SyncHash
#
# A thread-safe hash. We use a sync object instead of a mutex,
# because it is re-entrant. An exclusive lock is needed when
# writing, a shared lock IS NEEDED when reading.
#
# Uses the delegator pattern to allow for multiple
# implementations!
#
#   hash = SyncHash.new
#   hash = SyncHash.new(Hash.new)   # Delegates
#
# == Design
#
# This class uses the delegator pattern. However we don't use Ruby's
# delegation facilities, they are more general and powerful than we
# need here (and slower). Instead a custom (but simple) solution is
# used.
#
# == Usage
#
#   hash = SyncHash.new
#   hash = SyncHash.new(Hash.new)   # Delegates
#
class SyncHash < Hash

  attr :delegate, :sync

  def initialize(delegate=nil)
    @delegate = delegate
    @sync = ::Sync.new
    if delegate
      self.extend Delegator
    else
      self.extend Inheritor
    end
  end

  # Is this even advisable ?
  #def replace(new_delegate)
  #  self.extend Delegator unless @delegate
  #  # or? raise 'not a delegating synchash' unless @delegate
  #  @delegate = new_delegate
  #end

  # This module is used when a delegate is NOT being used.
  module Inheritor

    def [](key)
      @sync.synchronize(::Sync::SH) { super }
    end

    def []=(key, value)
      @sync.synchronize(::Sync::EX) { super }
    end

    def delete(key)
      @sync.synchronize(::Sync::EX) { super }
    end

    def clear
      @sync.synchronize(::Sync::EX) { super }
    end

    def size
      @sync.synchronize(::Sync::SH) { super }
    end

    def values
      @sync.synchronize(::Sync::SH) { super }
    end

    def keys
      @sync.synchronize(::Sync::SH) { super }
    end
  end

  # This module is used when a delegate is being used.
  module Delegator

    def [](key)
      @sync.synchronize(::Sync::SH) { @delegate[key] }
    end

    def []=(key, value)
      @sync.synchronize(::Sync::EX) { @delegate[key] = value }
    end

    def delete(key)
      @sync.synchronize(::Sync::EX) { @delegate.delete(key) }
    end

    def clear
      @sync.synchronize(::Sync::EX) { @delegate.clear }
    end

    def size
      @sync.synchronize(::Sync::SH) { @delegate.size() }
    end

    def values
      @sync.synchronize(::Sync::SH) { @delegate.values() }
    end

    def keys
      @sync.synchronize(::Sync::SH) { @delegate.keys() }
    end

  end #module Delegator

end #class SyncHash

#--
# Funniest thing, remove the :: in front of Sync.new in the initialize
# routine and uncomment the alias line below and watch the stack blow chunks.
# I'm leaving this comment here as a reminder.
### Hash::Sync = SyncHash
#++

