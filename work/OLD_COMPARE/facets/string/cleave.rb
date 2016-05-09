
class String

  def cleave(threshold=nil, len=nil)
    l = (len || size / 2) 
    t = threshold || size

    h1 = self[0...l]
    h2 = self[l..-1]

    i1 = h1.rindex(/\s/) || 0
    d1 = (i1 - l).abs

    d2 = h2.index(/\s/) || l
    i2 = d2 + l

    d1 = (i1-l).abs
    d2 = (i2-l).abs

    if [d1, d2].min > t
      i = t
    elsif d1 < d2
      i = i1
    else
      i = i2
    end

    #dup.insert(l, "\n").gsub(/^\s+|\s+$/, '')
    return self[0..i].to_s.strip, self[i+1..-1].to_s.strip
  end 

end



=begin test

   require 'test/unit'
   
  class StringCleaveTest < Test::Unit::TestCase
     def test_nospaces
       assert_equal [ 'whole', '' ], 'whole'.cleave
       assert_equal [ 'Supercalifragilisticexpialidocious', '' ],
                    'Supercalifragilisticexpialidocious'.cleave
     end
     def test_exact_middle
       assert_equal [ 'fancy', 'split' ], 'fancy split'.cleave
       assert_equal [ 'All good Rubyists', 'know how to party' ],
                    'All good Rubyists know how to party'.cleave
     end
     def test_closer_to_start
       assert_equal [ 'short', 'splitter' ], 'short splitter'.cleave
       assert_equal [ 'Four score and', 'seven years ago...' ],
                    'Four score and seven years ago...'.cleave
       assert_equal [ 'abc def', 'ghijklm nop' ],
                    'abc def ghijklm nop'.cleave
     end
     def test_closer_to_end
       assert_equal [ 'extended', 'split' ], 'extended split'.cleave
       assert_equal [ 'abc defghi', 'jklm nop' ],
                    'abc defghi jklm nop'.cleave
     end
   end

=end

