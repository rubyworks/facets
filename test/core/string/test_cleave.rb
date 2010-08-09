Covers 'facets/string/cleave'

Case String do

  table = [
    [ 'no spaces short word'    , 'whole'                              , ['whole', ''] ],
    [ 'no spaces long word'     , 'Supercalifragilisticexpialidocious' , ['Supercalifragilisticexpialidocious', ''] ],
    [ 'exact middle two words'  , 'fancy split'                        , ['fancy', 'split'] ],
    [ 'exact middle many words' , 'All good Rubyists know how to party', ['All good Rubyists', 'know how to party'] ],
    [ 'closer to start'         , 'short splitter'                     , ['short', 'splitter'] ],
    [ 'closer to start'         , 'Four score and seven years ago...'  , ['Four score and', 'seven years ago...'] ],
    [ 'closer to start'         , 'abc def ghijklm nop'                , ['abc def', 'ghijklm nop'] ],
    [ 'closer to end'           , 'extended split'                     , ['extended', 'split'] ],
    [ 'closer to end'           , 'abc defghi jklm nop'                , [ 'abc defghi', 'jklm nop'] ]
  ]

  table.each do |d, s, x|
    Unit :cleave => d do
      s.cleave.assert == x
    end
  end

end
