puts "Load levels"
levels = []
10.times do |i|
  levels << Level.find_or_create_by(name: "Level #{i}", description: "lalalala lalalala alal #{i}", position: i + 1)
end
puts "Levels loaded"

puts "Load characters"
characters = []
10.times do |i|
  characters << Character.find_or_create_by(name: "Krzysiek #{i}", level_id: levels[i].id)
end
puts "Characteres loaded"

puts "Load conversations"

conversations = []
levels.each do |level|
  conversations << Conversation.find_or_create_by(level_id: level.id)
end

puts "Conversations loaded!"
puts "Load messages"

conversations.each_with_index do |conversations, id|
  Message.find_or_create_by!(position: 1, content: "message #{id}", character_id: characters.first.id, conversation_id: conversations.id)
  Message.find_or_create_by!(position: 2, content: "message #{id}", character_id: characters[id + 1].try(:id), conversation_id: conversations.id)
end

puts "Messages loaded!"
