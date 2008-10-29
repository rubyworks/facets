module Enumerable

  # Split on matching pattern. Unlike #divide this does not include matching elements.
  #
  #   ['a1','a2','b1','a3','b2','a4'].split(/^b/)
  #   => [['a1','a2'],['a3'],['a4']]
  #
  # CREDIT: Trans

  def split(pattern)
    sect = []
    memo = []
    each do |obj|
      if pattern === obj
        memo << sect
        sect = []
      else
        sect << obj
      end
    end
    memo << sect #unless sect.empty?
    memo.pop while memo.last.empty?
    memo
  end

end

