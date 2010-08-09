class Hash

  # Like group_by, but allows hash values to be grouped with weeding out the keys.
  #
  #   Example:
  #
  #   birthdays = {...}   # Maps each person to his/her birthday.
  #
  # Now I want to have the list of people that have their birthday
  # on a specific date. This can be done by creating a hash first,
  # using group_by:
  #
  #   birthdays.group_by{|person, birthday| birthday}
  #
  # This returns:
  #
  # {date=>[[person1, date], [person2, date], [person3, date]]}
  #
  # ... which is a bit inconvient. Too many dates. I would rather
  # like to have:
  #
  #   {date=>[person1, person2, person3]]}
  #
  # This can be achieved by:
  #
  #   birthdays.inject!({}){|h, (person, date)| (h[date] ||= []) << person}
  #
  # I've used this pattern just once too often, so I moved the code
  # to Hash (and Enumerable, for associative arrays). Here's the
  # cleaner code:
  #
  # birthdays.group_by_value
  #
  #   h = {"A"=>1, "B"=>1, "C"=>1, "D"=>2, "E"=>2, "F"=>2, "G"=>3, "H"=>3, "I"=>3}
  #
  #   h.group_by{|k, v| v}    # ==> {1=>[["A", 1], ["B", 1], ["C", 1]], 2=>[["D", 2], ["E", 2], ["F", 2]], 3=>[["G", 3], ["H", 3], ["I", 3]]}
  #   h.group_by_value        # ==> {1=>["A", "B", "C"], 2=>["D", "E", "F"], 3=>["G", "H", "I"]}
  #   h.sort.group_by_value   # ==> [[1, ["A", "B", "C"]], [2, ["D", "E", "F"]], [3, ["G", "H", "I"]]]
  #
  # CREDIT: Erik Veenstra
  
  def group_by_value
    res = {}
    each{|k, v| (res[v] ||= []) << k}
    res
  end

end


# Not sure this is a good idea for enumerable.
#
#module Enumerable
#
#  # For associative arrays, like the result of Hash#sort.
#  #
#  def group_by_value
#    kv  = k = v = nil
#    res = []
#    each{|k, v| (res.assoc(v) || (res << kv=[v, []]; kv)).last << k}
#    res
#  end
#
#end

