class String

  alias_method :_crypt, :crypt

  # Common Unix cryptography method.
  # This adds a default salt to the built-in crypt method.
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/string/crypt'
  #
  def crypt(salt=nil)
    salt ||= (
      (rand(26) + (rand(2) == 0 ? 65 : 97) ).chr +
      (rand(26) + (rand(2) == 0 ? 65 : 97) ).chr
    )
    _crypt(salt)
  end

end
