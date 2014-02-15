class String

  # Rotate string to the left with count.
  # Specifying negative number indicates rotation to the right.
  #
  #   'abcdefgh'.rotate(2)  #=> 'cdefghab'
  #   'abcdefgh'.rotate(-2) #=> 'ghabcdef'
  #
  # CREDIT: T. Yamada
  def rotate(count=1)
    count+=self.length if count<0
    self.slice(count,self.length-count)+self.slice(0,count)
  end

  # Destructive version of String#rotate
  #
  #   s='abcdefgh'
  #   s.rotate!(2)
  #   s.should eq 'cdefghab'
  #
  # CREDIT: T. Yamada
  def rotate!(count=1) replace(rotate(count)) end

end
