covers 'facets/string/unbracket'

testcase String do

  unit :unbracket do
    s = "{unwrap me}"
    z = s.unbracket('{')
    z.assert == "unwrap me"

    s = "--unwrap me!"
    z = s.unbracket('--','!')
    z.assert == "unwrap me"
  end

  unit :unbracket! do
    s = "{unwrap me}"
    s.unbracket!('{')
    s.assert == "unwrap me"

    s = "--unwrap me!"
    s.unbracket!('--','!')
    s.assert == "unwrap me"
  end

end

