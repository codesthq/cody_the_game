def create_level(params:)
  Level.create! params
end

def create_character(params:, level:)
  Character.create! params.merge! level_id: level
end

def create_task(params:, level:)
  Task.create! params.merge! level_id: level, test_class: "Challenge::HelloWorld"
end

def create_conversation(messages:, characters:, level:)
  conversation = Conversation.create! level_id: level

  messages.each_with_index do |message, i|
    character = characters[i % characters.size]

     message.merge!(
      conversation_id: conversation.id,
      character_id:    character.id
    )

    Message.create! message
  end
end

cody = { name: "Cody" }

opponents = [
  { name: "Jarek" },
  { name: "Pikachu" },
  { name: "Michal" },
  { name: "Tomek" },
  { name: "Bartek" },
  { name: "Dawid" },
  { name: "Radek" }
]

levels = [
  { name: "McDonald's", description: "Hotdogs question" },
  { name: "Eyebrows", description: "Eyebrows question" },
  { name: "Batteries", description: "Batteries question" },
  { name: "Handcuffs", description: "Handcuffs question" },
  { name: "Animals suicide", description: "Animals question" },
  { name: "Money on trees", description: "Money question" },
  { name: "Ketchup", description: "Ketchup question" }
]

tasks = [
  { content: "Why doesn't McDonald's sell hotdogs? ", points: 2, start_code: "What do you think, hmm?" },
  { content: "Are eyebrows considered facial hair?", points: 1 },
  { content: "Why are there no 'B' batteries? ", points: 2 },
  { content: "How do you handcuff a one-armed man?", points: 3 },
  { content: "Can animals commit suicide?", points: 4 },
  { content: "If money doesn't grow on trees then why do banks have branches?", points: 2 },
  { content: "What's the difference between normal ketchup and fancy ketchup?", points: 5, start_code: "Just ketchup" }
]

conversations = [
  [
    { content: "Hello Cody!" },
    { content: "Hello!" }
  ],

  [
    { content: "You don't need that dude..." },
    { content: "That's right!" }
  ],

  [
    { content: "You wont't solve this task ever!" },
    { content: "I'm not amused" }
  ]
]

levels.each_with_index do |level_params, i|
  level = create_level params: level_params

  create_task(params: tasks[i], level: level.id)

  level_characters = [
    create_character(params: cody,         level: level.id),
    create_character(params: opponents[i], level: level.id)
  ]

  create_conversation(
    messages:   conversations[i % conversations.size],
    characters: level_characters,
    level:      level.id
  )
end
