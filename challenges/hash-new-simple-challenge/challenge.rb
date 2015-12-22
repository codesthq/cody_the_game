foo = Hash.new(Array.new)
#foo = Hash.new { |hash, key| hash[key] = Array.new }
foo[:first] << 1
foo[:first] << 2
foo[:second] << 3
foo[:second] << 4

puts foo[:first] == [1, 2]
puts foo[:second] == [3, 4]
