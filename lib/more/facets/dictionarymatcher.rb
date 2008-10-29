class DictionaryMatcher
  attr_reader :word_count

  #Contains the index matched, and the word matched
  class MatchData < Struct.new(:index,:match)
    def inspect
      "#{match.inspect}@#{index}"
    end
  end

  def inspect
    to_s
  end

  #Create a DictionaryMatcher with no words in it
  def initialize
    @trie = {}
    @word_count = 0
  end

  #Add a word to the DictionaryMatcher
  def add(word)
    @word_count += 1
    container = @trie
    containers=[]

    i=0
    word.each_byte do |b|
      container[b] = {} unless container.has_key? b
      container[:depth]=i
      containers << container
      container = container[b]
      i+=1
    end
    containers << container

    container[0] = true # Mark end of word
    container[:depth]=i
     
    ff=compute_failure_function word
    ff.zip(containers).each do |pointto,container|
      container[:failure]=containers[pointto] if pointto
    end

    self

  end

  alias << add

  def compute_failure_function p
    m=p.size
    pi=[nil,0]
    k=0
    2.upto m do |q|
      k=pi[k] while k>0 and p[k] != p[q-1]
      k=k+1 if p[k]==p[q-1]
      pi[q]=k
    end
    pi
  end
  private :compute_failure_function

   #Determine whether +string+ was previously <tt>add</tt>ed to the 
   #Trie.
  def include?(word)
    container = @trie
    word.each_byte do |b|
      break unless container.has_key? b
      container = container[b]
    end
    container[0]
  end

   #Determines whether one of the words in the DictionaryMatcher is a 
   #substring of
   #+string+. Returns the index of the match if found, +nil+ if not 
   #found.
  def =~ text
    internal_match(text){|md| return md.index}
    nil
  end

   #Determine whether one of the words in the DictionaryMatcher is a 
   #substring of
   #+string+. Returns a DictionaryMatcher::MatchData object if found, 
   #+nil+ if not #found.
  def match text
    internal_match(text){|md| return md}
    nil
  end

  def internal_match string
      node=@trie
      pos=0
      string.each_byte do |b|
	 advance=false
	 until advance
	    nextnode=node[b]
	    if not nextnode
	       if node[:failure]
		  node=node[:failure]
	       else
		  advance=true 
	       end
	    elsif nextnode[0]
	       yield MatchData.new(pos, string[pos+1-nextnode[:depth],nextnode[:depth]])
	       advance=true
	       node=@trie
	    else
	       advance=true
	       node=nextnode
	    end
	    pos+=1
	 end
      end
  end
  private :internal_match

   #Scans +string+ for all occurrances of strings in the 
   #DictionaryMatcher.
   #Overlapping matches are skipped (only the first one is yielded), and 
   #when some strings in the
   #DictionaryMatcher are substrings of others, only the shortest match 
   #at a given position is found.
  def scan(text, &block)
    matches=[]
    block= lambda{ |md| matches << md } unless block
    internal_match(text,&block)
    matches
  end

  #Case equality. Similar to =~.
  alias_method :===, :=~
end

