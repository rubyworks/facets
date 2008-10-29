class Array

  #

  def traverse(&block)
    map do |item|
      if item.is_a?(self.class)
        item.traverse(&block)
      else
        yield item
      end
    end
  end

  #

  def traverse!(&block)
    replace(traverse(&block))
  end

end

