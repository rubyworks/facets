class << ObjectSpace
  alias_method :[], :_id2ref
end
