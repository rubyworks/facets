module Enumerable

  # Split on matching pattern. Unlike #divide this does not include matching elements.
  #
  #   ['a1','a2','b1','a3','b2','a4'].split(/^b/)
  #   => [['a1','a2'],['a3'],['a4']]
  #
  # CREDIT: Trans

  def split(pattern)
    memo = []
    sect = []
    each do |obj|
      if pattern === obj
        memo << sect
        sect = []
      else
        sect << obj
      end
    end
    memo << sect
    memo.pop while memo.last == []
    memo
  end

end

