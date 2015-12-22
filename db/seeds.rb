## Levels
10.times do |i|
  Level.find_or_create_by(name: "Level #{i}", description: "lalalala lalalala alal #{i}")
end

puts "Levels loaded"
