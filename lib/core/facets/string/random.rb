class String

  # Create a random String of given length, using given character set
  #
  # Examples
  #
  #     String.random
  #     => "D9DxFIaqR3dr8Ct1AfmFxHxqGsmA4Oz3"
  #
  #     String.random(10)
  #     => "t8BIna341S"
  #
  #     String.random(10, ['a'..'z'])
  #     => "nstpvixfri"
  #
  #     String.random(10, ['0'..'9'] )
  #     => "0982541042"
  #
  #     String.random(10, ['0'..'9','A'..'F'] )
  #     => "3EBF48AD3D"
  #
  # CREDIT: Tilo Sloboda
  #
  # SEE: https://gist.github.com/tilo/3ee8d94871d30416feba
  #
  # TODO: Move to random.rb in standard library?

  def self.random(len=32, character_set = ["A".."Z", "a".."z", "0".."9"])
    chars = character_set.map(&:to_a).flatten
    Array.new(len){ chars.sample }
  end

end
