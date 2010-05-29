Covers 'facets/string/unindent'

Case String do

  Concern "Single-line indentation"

  Unit :unindent => "removes space indentation" do
    "\s\sabc".unindent.assert == "abc"
  end

  Unit :unindent => "removes_tab_indentation" do
    "\tabc".unindent.assert == "abc"
  end

  Unit :unindent => "removes space and tab indentation" do
    "\t\sabc".unindent.assert == "abc"
  end

  Concern "Multi-line indentation"

  Unit :unindent => "removes indentation" do
    "\tabc\n\tabc".unindent.assert == "abc\nabc"
  end

  Unit :unindent => "keeps relative indentation" do
    "\tabc\n\t\tabc".unindent.assert == "abc\n\tabc"
  end

  Unit :unindent => "ignores blank lines for indent calculation" do
    "\n\tabc\n\n\t\tabc\n".unindent.assert == "\nabc\n\n\tabc\n"
  end

  Concern "Inplace method"

  Unit :unindent! => "modifies string in place" do
    str = "\s\sabc"
    str.unindent!
    str.assert == "abc"
  end

end

