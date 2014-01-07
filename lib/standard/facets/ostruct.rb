require 'ostruct'
require 'facets/ostruct/initialize'
require 'facets/ostruct/to_h'
require 'facets/ostruct/merge'
require 'facets/ostruct/each'
require 'facets/ostruct/to_ostruct'
require 'facets/ostruct/op_fetch'
require 'facets/ostruct/op_store'

class OpenStruct

  #--
  # TO BE DEPRECATED
  # Must consider that accessing instance_delegate instead can be dangerous.
  # Might we us a Functor to ensure the table keys are always symbols?
  #++

  # Provides access to an OpenStruct's inner table.
  #
  #   o = OpenStruct.new
  #   o.a = 1
  #   o.b = 2
  #   o.instance_delegate.map { |k, v| "#{k} #{v}" }
  #   #=> ["a 1", "b 2"]
  #
  # @deprecated Use `#marshal_dump` instead.
  #
  def instance_delegate
    warn "OpenStruct#instance_delegate is deprecated, use #marshal_dump instead."
    @table
  end

  # @deprecated Use `#marshal_dump` instead.
  alias ostruct_delegate instance_delegate

  # Insert/update hash data on the fly.
  #
  #   o = OpenStruct.new
  #   o.ostruct_update(:a => 2)
  #   o.a  #=> 2
  #
  # @deprecated Use #merge! instead.
  #
  def ostruct_update(other)
    warn "OpenSrtuct#ostruct_update has been deprecated. Use #merge! instead."
    merge!(other)
  end

  # Insert/update hash data on the fly.
  #
  #   o = OpenStruct.new
  #   o.ostruct_update(:a => 2)
  #   o.a  #=> 2
  #
  # @deprecated Use #merge! instead.
  #
  def __update__(other)
    raise NameError, "OpenSrtuct#__update__ has been deprecated. Use #merge! instead."
    #merge!(other)
  end

  # TODO: How to handle regular merge, since it lacks punctuation to make it safe.
  #       Maybe `#update!`? Kind of odd but could work.

  # Merge hash data creating a new OpenStruct object.
  #
  #   o = OpenStruct.new
  #   x = o.ostruct_merge(:a => 2)
  #   x.a  #=> 2
  #
  def ostruct_merge(other)
    o = dup
    o.merge!(other)
    o
  end

  # Merge hash data creating a new OpenStruct object.
  #
  #   o = OpenStruct.new
  #   x = o.__merge__(:a => 2)
  #   x.a  #=> 2
  #
  def __merge__(other)
    o = dup
    o.merge!(other)
    o
  end

end

# Copyright (c) 2005 Thomas Sawyer (Ruby License)
