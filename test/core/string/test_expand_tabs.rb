covers 'facets/string/expand_tab'

test_case String do

  setup do
    @tabs = <<-EOF

\tOne tab
 \tOne space and one tab
    \t Six spaces, a tab, and a space
    EOF
  end

  method :expand_tabs do

    test "0" do
      expected = <<-EOF

One tab
 One space and one tab
     Six spaces, a tab, and a space
      EOF
      @tabs.expand_tabs(0).assert == expected
    end

    test "1" do
      expected = <<-EOF

 One tab
  One space and one tab
      Six spaces, a tab, and a space
      EOF
      @tabs.expand_tabs(1).assert == expected
    end

    test "4" do
      expected = <<-EOF

    One tab
    One space and one tab
         Six spaces, a tab, and a space
      EOF
      @tabs.expand_tabs(4).assert == expected
    end

    test "8" do
      expected = <<-EOF

        One tab
        One space and one tab
         Six spaces, a tab, and a space
      EOF
      @tabs.expand_tabs.assert == expected
      @tabs.expand_tabs(8).assert == expected
    end

    test "16" do
      expected = <<-EOF

                One tab
                One space and one tab
                 Six spaces, a tab, and a space
      EOF
      @tabs.expand_tabs(16).assert == expected
    end

  end

  method :expand_tab do

    test "0 (alias for #expand_tabs)" do
      expected = <<-EOF

One tab
 One space and one tab
     Six spaces, a tab, and a space
      EOF
      @tabs.expand_tab(0).assert == expected
    end

  end

end
