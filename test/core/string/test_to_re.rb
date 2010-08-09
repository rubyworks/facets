Covers 'facets/string/to_re'

Case String do

  Unit :to_re do
    "abc".to_re.assert == /abc/
    "a+bc".to_re.assert == /a+bc/
    "a+bc".to_re(false).assert == /a+bc/
    "a+bc".to_re(true).assert == /a\+bc/
  end

  Unit :to_re => "escaped characters" do
    a = "?"
    b = /#{a.to_rx}/
    assert( b =~ "?" )
  end

  Unit :to_rx do
    "abc".to_rx.assert == /abc/
    "a+bc".to_rx.assert == /a\+bc/
    "a+bc".to_rx(false).assert == /a+bc/
    "a+bc".to_rx(true).assert == /a\+bc/
  end

end

