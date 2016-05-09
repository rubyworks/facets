module Enumerable

  # Clusters together adjacent elements into a list of sub-arrays.
  #
  #     [2,2,2,3,3,4,2,2,1].cluster{ |x| x }
  #     => [[2, 2, 2], [3, 3], [4], [2, 2], [1]]
  #
  #     ["dog", "duck", "cat", "dude"].cluster{ |x| x[0] }
  #     => [["dog", "duck"], ["cat"], ["dude"]]
  #
  # @author Oleg K

  def cluster
    cluster = []
    each do |element|
      if cluster.last && yield(cluster.last.last) == yield(element)
        cluster.last << element
      else
        cluster << [element]
      end
    end
    cluster
  end

end

