require 'facets/string/expand_tab'

Case String do

    tabs = <<-EOF

\tOne tab
 \tOne space and one tab
    \t Six spaces, a tab, and a space
    EOF


  Unit :expand_tabs => "0" do
    expected = <<-EOF

One tab
 One space and one tab
     Six spaces, a tab, and a space
    EOF
    tabs.expand_tabs(0).assert == expected
  end


  Unit :expand_tabs => "1" do
    expected = <<-EOF

 One tab
  One space and one tab
      Six spaces, a tab, and a space
    EOF
    tabs.expand_tabs(1).assert == expected
  end


  Unit :expand_tabs => "4" do
    expected = <<-EOF

    One tab
    One space and one tab
         Six spaces, a tab, and a space
    EOF
    tabs.expand_tabs(4).assert == expected
  end


  Unit :expand_tabs => "8" do
    expected = <<-EOF

        One tab
        One space and one tab
         Six spaces, a tab, and a space
    EOF
    tabs.expand_tabs.assert == expected
    tabs.expand_tabs(8).assert == expected
  end


  Unit :expand_tabs => "16" do
    expected = <<-EOF

                One tab
                One space and one tab
                 Six spaces, a tab, and a space
    EOF
    tabs.expand_tabs(16).assert == expected
  end

end

