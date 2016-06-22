def find_or_create_level(params:)
  Level.find_or_create_by!(position: params[:position]) do |level|
    level.name        = params[:name]
    level.description = params[:description]
  end
end

def find_or_create_character(params:, level_id:)
  character = Character.find_or_create_by!(level_id: level_id, name: params[:character][:name])
  puts "        #{character.inspect} created / updated!"
  character
end

def find_or_create_task(params:, level_id:)
  t = Task.find_or_create_by!(test_class: params[:test_class], level_id: level_id) do |task|
    task.content  = params[:content]
    task.points   = params[:points]
  end
  # puts "   Task #{t.id}) Level #{t.level_id}, #{t.test_class} updated / created!"
end

def find_or_create_conversation(messages:, level_id:)
  conversation = Conversation.find_or_create_by! level_id: level_id

  messages.each_with_index do |message, i|
    character = find_or_create_character(params: message, level_id: level_id)
    message_object = Message.find_or_create_by!(conversation_id: conversation.id, character_id: character.id) do |m|
      m.content = message[:content]
    end
    # puts "\t#{message_object.inspect} updated / created!"
  end
end

cody = { name: "Cody" }

migration_data = [
    {
        position: 1,
        name: "Mad dog level",
        description: "Mad dog question",
        conversation: {
            messages: [
                {
                    content:   "What was I talking about? Ah, right. The forest says some wimpy troll is trying to get to the top. So take that little backpack of yours and get back to coding in XHTML.Take two steps back, then straight down and you're there.",
                    character: { name: "The rabid dog" }
                },
                {
                    content:   "Are you gonna bark, doggie, or are you gonna bite? I'll do whatever the hell I want to.",
                    character: cody
                }
            ]
        },
        task: {
            content: <<-CODE.strip_heredoc,
              Write such a code that allows to use ~:foo syntax in 'case' statement like this:

              o = ...
              case o
                when ~:new  then puts "o responds to :new method"
                when ~:size then puts "o responds to :size method"
              end

              # for o = [] expected output is  "o responds to :size method"
              # for o = String expected output is  "o responds to :new method"

              Your code should work with any king of object.
            CODE
            points: 2, start_code: "What do you think, hmm?", test_class: "Challenge::Case"
        }
    },
    {
        position: 2,
        name: "Witch level",
        description: "Witch question",
        conversation: {
            messages: [
                {
                    content: "You call this a codekiller? This is a damn parody, not a codekiller!",
                    character: { name: "The witch" }
                },
                {
                    content: "Chill out, man. Have a smoke, get some popcorn, kick back in the front row and just watch the show I made for this occasion.",
                    character: cody
                }
            ]
        },
        task: {
            content: "Writing ordinary if statement is boring. Implement this funny looking conditional statement.\n\n(1 == 1).--> { puts 'true' } { puts 'false' }\n# should print 'true'\n (0 >= 1).--> { puts 'true' } { puts 'false' }\n # should print 'false'\n (0 >= 1).--> { puts 'true' }\n # should do nothing",
            points: 1, test_class: "Challenge::ConditionalStatement"
        }
    },
    {
        position: 3,
        name: "Robot level",
        description: "Robots question",
        conversation: {
            messages: [
                {
                    content: "See those moves? You'll never get half as good as that. So just let go, choose some simple job that will prove that manual skills are way better than brains and just give it your 100%.",
                    character: { name: "The robot" }
                },
                {
                    content: "What? Sorry, I didn't hear you, could you repeat? I thought I heard a fart... or maybe it was just your dumbass idea to shame me flying in the distance.",
                    character: cody
                }
            ]
        },
        task: {
            content: "Implement class Squirrel in a way below API will be supported.\n\nsquirrel = Squirrel.new\n squirrel.fight do\n jump\n kick\n punch\n jump\n end\n squirrel.actions #=> ['jump', 'kick', 'punch', 'jump']",
            points: 2, test_class: "Challenge::Dsl"
        }
    },
    {
        position: 4,
        name: "Golem's level",
        description: "Golem question",
        conversation: {
            messages: [
                {
                    content: "Hello, little man. I heard a lot about you. Remind me, what words do you want on your tombstone?",
                    character: { name: "The golem" }
                },
                {
                    content: "Chill, man, easy with those cheesy threats. I'll move heaven and earth to make you run like hell to the deepest cracks this planet has. And even there, my people will find you, they'll get you and blow you to pieces with heavy ammo.",
                    character: cody
                }
            ]
        },
        task: {
            content: "I removed find_all method from Array class!\nImplement your own Array#find_all method so for example: [1, 2, 3, 4].find_all { |e| e > 2 }  would return [3, 4].",
            points: 3, test_class: "Challenge::FindAll"
        }
    },
    {
        position: 5,
        name: "Dictator suicide",
        description: "Dictator question",
        conversation: {
            messages: [
                {
                    content: "Get this... this thing out of my sight! How dare this dwarf half-cat, half-rat stand before my majesty and pick up the gauntlet like that!",
                    character: { name: "The dictator" }
                },
                {
                    content: "I'm blinded, sir. I went blind when I saw your arrogant foolery. Let me show you what I can do.",
                    character: cody
                }
            ]
        },
        task: {
            content: "Write a program which prints 'Hello World!' on the screen.",
            points: 4, test_class: "Challenge::HelloWorld"
        }
    },
    {
        position: 6,
        name: "Bad cop on trees",
        description: "Bad cop question",
        conversation: {
            messages: [
                {
                    content: "We'll start with a ticket for exceeding height limit. You'll go to jail for some year and a half, by the new regulations.",
                    character: { name: "The bad cop" }
                },
                {
                    content: "How about you switch that toy gun for a real one? Then we can shoot at one another. Oh, and another thing. I don't really wanna kill anyone but if I want to climb that tree by this branch and you're in my way, then you'll have to move out of it anyway.",
                    character: cody
                }
            ]
        },
        task: {
            content: "Write a method called format_number which converts given integer number to string like this:\n\nformat_number(1234)    #=> '1_234'\nformat_number(-1234)   #=> '-1_234'\nformat_number(134567)  #=> '134_567'\nformat_number(49)      #=> '49'",
            points: 1, start_code: "def setup; puts 'hehe'; end", test_class: "Challenge::FormatNumber"
        }
    },
    {
        position: 7,
        name: "Clown",
        description: "Clown question",
        conversation: {
            messages: [
                {
                    content: "I know what you'll be perfect for. I'll make a little dog-shaped balloon for 3-years-old girls out of you!",
                    character: { name: "The clown" }
                },
                {
                    content: "You wanna continue this philosophical dispute here or shall I call other local people to join us?",
                    character: cody
                }
            ]
        },
        task: {
            content: "I removed % operator for integer numbers!\nRe-implement it in a way following code will work properly:\n\n10 % 3 #=> 1\n23 % 0 # raises ZeroDivisionError error\n\nDon't worry about negative numbers. I don't care about them.",
            points: 2, test_class: "Challenge::Modulo"
        }
    },
    {
        position: 8,
        name: "Mother-in-law suicide",
        description: "Mother-in-law question",
        conversation: {
            messages: [
                {
                    content: "Where are you going, son? I knew you'd be good for nothing.I always said you look grotesque, like half-bush, half-hedgehog. Get off here.",
                    character: { name: "The mother-in-law" }
                },
                {
                    content: "Looks like your husband doesn't love you anymore. You make me me temporarily sick of people. You're the worst. But hang on, I'll show you I'm not here by accident.",
                    character: cody
                }
            ]
        },
        task: {
            content: <<-CODE.strip_heredoc,
              Implement a method 'change_object' in such a way that
              object.size == 0 will return 'Hello World!' string.

              object = Object.new
              change_object(object)
              object.size == 0 # should return 'Hello World!'
            CODE
            points: 5, start_code: "Just ketchup", test_class: "Challenge::OperatorChange"
        }
    },
    {
        position: 9,
        name: "Radioactive rat",
        description: "Radioactive rat question",
        conversation: {
            messages: [
                {
                    content: "Listen, kid, I'll be honest with you, okay? I couldn't care less about what you know and what you don't. What matters to me now is having some fun watching you fall.",
                    character: { name: "The radioactive rat" }
                },
                {
                    content: "Damn, I don't remember buying funfair tickets. Thanks, I'll keep those. And speaking of fun: you'll get some in a second when I push you down.",
                    character: cody
                }
            ]
        },
        task: {
            content: "Write a program which prints sentence <strong><i>Ruby was released in 1995!</i></strong> on screen using only following characters [a-zA-Z.&#92;n ] (small & big letters, dot, space and new line)",
            points: 8, test_class: "Challenge::RubyWasReleased"
        }
    },
    {
        position: 10,
        name: "Hunter",
        description: "Hunter question",
        conversation: {
            messages: [
                {
                    content: "This is where your field trip ends. You won't take another step. This is your last stop on Earth so better have a good look and remember it well.",
                    character: { name: "The hunter" }
                },
                {
                    content: "Oh come on, I'm a master of taking on wimps like you. First of all, turn this gun around because right now you're aiming at yourself. Then put some real bullets in it and tie your shoes. And then turn around, close your eyes and forget you even thought about this shitshow. Stop making a fool of yourself, get a new hobby, like collecting stamps or pottery, and just give up on going teen gangsta. And look here!",
                    character: cody
                }
            ]
        },
        task: {
            content: "Here is the funny method I wrote once:\n\ndef ruby_love\nWe ♥ Ruby! What about you?\nend\n\n This method should return 'I ♥ Ruby too!' string. You can't change ruby_love method at all.",
            points: 6, test_class: "Challenge::RubyLove"
        }
    }
]

migration_data.each.with_index(1) do |level_data, i|
  level = find_or_create_level params: level_data
  puts "#{i}) Level #{level.id}, #{level.name} (position: #{level.position}) updated / created!"

  find_or_create_task(params: level_data[:task], level_id: level.id)
  find_or_create_conversation(messages: level_data[:conversation][:messages], level_id: level.id)
end
