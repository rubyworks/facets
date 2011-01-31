covers 'facets/string/to_re'

testcase String do

  unit :to_re do
    "abc".to_re.assert == /abc/
    "a+bc".to_re.assert == /a+bc/
    "a+bc".to_re(false).assert == /a+bc/
    "a+bc".to_re(true).assert == /a\+bc/
  end

  unit :to_rx do
    "abc".to_rx.assert == /abc/
    "a+bc".to_rx.assert == /a\+bc/
    "a+bc".to_rx(false).assert == /a+bc/
    "a+bc".to_rx(true).assert == /a\+bc/
  end

  unit :to_rx => "escaped characters" do
    a = "?"
    b = /#{a.to_rx}/
    b.assert =~ "?"
    b.refute =~ "X"
  end

end

