counter = Hash.new(Hash.new(0))

counter[:first][:second] = 3
puts counter[:first][:second] == 3
