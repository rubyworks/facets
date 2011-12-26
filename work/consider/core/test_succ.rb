Covers 'facets/succ.rb'

TestCase String do

  unit :succ do
    "a".succ    .assert == "b"
    "a".succ(1) .assert == "b"
    "a".succ(2) .assert == "c"
    "a".succ(3) .assert == "d"
  end

end

# TODO: We are testing Numeric via Fixnum. Not sure why we need to do this
# but it doesn't work otherwise. Eventually we need to figure ouy why, but
# it's okay for now.

TestCase Fixnum do

  unit :pred do
     4.pred     .assert ==  3 
    -2.pred     .assert == -3 
     4.pred(2)  .assert ==  2
    -2.pred(2)  .assert == -4
     4.pred(-2) .assert ==  6
    -2.pred(-2) .assert ==  0
  end

  unit :succ do
     4.succ     .assert ==  5  
    -2.succ     .assert == -1 
     4.succ(2)  .assert ==  6
    -2.succ(2)  .assert ==  0
     4.succ(-2) .assert ==  2 
    -2.succ(-2) .assert == -4
  end

end

