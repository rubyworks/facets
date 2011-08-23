class String

  # A fuzzy matching mechanism. Returns a score from 0-1, based
  # on the number of shared edges. To be effective, the strings
  # must be of length 2 or greater.
  #
  #   "Alexsander".similarity("Aleksander")  #=> 0.9
  #
  # The way it works:
  #
  # 1. Converts each string into a "graph like" object, with edges ...
  #
  #     "alexsander" -> [ alexsander, alexsand, alexsan ... lexsand ... san ... an, etc ]
  #     "aleksander" -> [ aleksander, aleksand ... etc. ]
  #
  # 2. Perform match, then remove any subsets from this matched set (i.e. a hit
  # on "san" is a subset of a hit on "sander") ...
  #
  #     Above example, once reduced -> [ ale, sander ]
  #
  # 3. See's how many of the matches remain, and calculates a score based
  # on how many matches, their length, and compare to the length of the
  # larger of the two words.
  #
  # Still a bit rough. Any suggestions for improvement are welcome.
  #
  # CREDIT: Derek Lewis.
  def similarity(str_in)
    return 0 if str_in == nil
    return 1 if self == str_in

    # -- make a graph of each word (okay, its not a true graph, but is similar)
    graph_A = Array.new
    graph_B = Array.new

    # -- "graph" self
    last = self.length
    (0..last).each do |ff|
      loc  = self.length
      break if ff == last - 1
      wordB = (1..(last-1)).to_a.reverse!
      if (wordB != nil)
        wordB.each do |ss|
          break if ss == ff
          graph_A.push( "#{self[ff..ss]}" )
        end
      end
    end

    # -- "graph" input string
    last = str_in.length
    (0..last).each{ |ff|
      loc  = str_in.length
      break if ff == last - 1
      wordB = (1..(last-1)).to_a.reverse!
      wordB.each do |ss|
        break if ss == ff
        graph_B.push( "#{str_in[ff..ss]}" )
      end
    }

    # -- count how many of these "graph edges" we have that are the same
    matches = graph_A & graph_B

    #--
    #matches = Array.new
    #graph_A.each{ |aa| matches.push(aa) if( graph_B.include?(aa) ) }
    #++

    # -- for eliminating subsets, we want to start with the smallest hits.
    matches.sort!{|x,y| x.length <=> y.length}

    # -- eliminate any subsets
    mclone = matches.dup
    mclone.each_index do |ii|
      reg = Regexp.compile( Regexp.escape(mclone[ii]) )
      count = 0.0
      matches.each{|xx| count += 1 if xx =~ reg}
      matches.delete(mclone[ii]) if count > 1
    end

    score = 0.0
    matches.each{ |mm| score += mm.length }
    self.length > str_in.length ? largest = self.length : largest = str_in.length
    return score/largest
  end

end

