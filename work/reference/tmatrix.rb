require 'matrix.rb'

class StickMatrix < Matrix
end

sm = StickMatrix[[0,1,0]]
cl = sm.clone
p cl.class

