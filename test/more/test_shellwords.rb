covers 'facets/shellwords'

tests Array do

  unit :shellwords do
    e = ["a", "b"]
    a = ["a", "b"].shellwords
    a.assert == e
  end

  unit :shellwords do
    e = ["-d", "a", "b"]
    a = ["a", "b", {:d=>true}].shellwords
    a.assert == e
  end

end

tests Hash do

  unit :shellwords do
    e = ['--debug']
    a = {:debug=>true}.shellwords
    a.assert == e
  end

  unit :shellwords do
    e = ['--name="jim"', '--debug']
    a = {:debug=>true, :name=>"jim"}.shellwords
    a.each do |x|
      e.assert.include?(x)
    end
  end

end


tests Shellwords do

  meta :shellwords do
    cmd = "ruby my_prog.rb | less"
    Shellwords.shellwords(cmd).assert.instance_of?(Array)
    Shellwords.shellwords(cmd).length.assert == 4
  end

  meta :shellwords => "unmatched double quote" do
    bad_cmd = 'one two "three'
    expect ArgumentError do
      Shellwords.shellwords(bad_cmd)
    end
  end

  meta :shellwords => "unmatched single quote" do
    bad_cmd = "one two 'three"
    expect ArgumentError do
      Shellwords.shellwords(bad_cmd)
    end
  end

  meta :shellwords => "unmatched quotes" do
    bad_cmd = "one '"'"''""'""
    expect ArgumentError do
      Shellwords.shellwords(bad_cmd)
    end
  end

end

