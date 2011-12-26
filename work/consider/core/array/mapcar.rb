# = TITLE:
#
#   Mapcar
#
# AUTHOR:
#
#   Cosmin Bonchis
#
# NOTES:
#
#   Google Summer of Code 2007 project for Ruby Central Inc.
#
# TODO:
#   - #mapcar should ne be defined in toplevel. But Matrix
#    is using it at class-level. WTF?

require 'generator'

#module Enumerable

  # Non-recursive mapcar (works on all Enumerables)

  def mapcar(*enums)
    generators = enums.collect { |e| Generator.new(e) }
    result = []
    while true
      begin
        params = generators.collect { |g| g.current; g.next }
          rescue EOFError
        return result
      end
      result << yield(*params)
    end
  end

  #

  def map(*enums)
    generators = []; enums.each { |e| generators << Generator.new(e) }
    while true
      begin
        params = []; generators.each { |g| g.current; params << g.next }
          rescue EOFError
        return
      end
      yield(*params)
    end
  end

#end


class Array

  def self.map(n, *arrays)
    len = arrays.length
    if n == 0
      n = arrays[0].length
      1.upto(arrays.length - 1) do |i|
        al = arrays[i].length
        n = al if al < n
      end
    end
    0.upto(n - 1) do |i|
      params = []
      0.upto(len - 1) do |arr|
        params << arrays[arr][i]
      end
      yield(*params)
    end
  end

end

