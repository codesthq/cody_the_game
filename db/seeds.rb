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
                    content:   "O czym ja to mówiłem? Aaa! Las donosi, że jakiś cienki troll próbuje się dostać na szczyt. Zabieraj lepiej ten plecaczek i wracaj pokodować w logomocji*“. Dwa kroki w tył. Potem prosto w doł i już jesteś w miejscu przeznaczenia.",
                    character: { name: "Wściekły pies" }
                },
                {
                    content:   "Będziesz tak szczekał pieseczku, czy będziesz gryzł?. Będę robił co mi się, cholera / kurka wodna/ motyla noga / proszę ja ciebie/  zachce",
                    character: cody
                }
            ]
        },
        task: {
            content: "I have a funny case for you!\nWrite such a code that allows to use ~:foo syntax in 'case' statement like this:\nany_object = []\ncase any_object\nwhen ~:foo\n# any_object responds to :foo method\nwhen ~:size\n# any_object responds to :size method\nelse\nend",
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
                    content: "To jest codekiller? To jest jakaś popierdółka a nie codekiller!“ CODY - PARODY!",
                    character: { name: "Czarownica" }
                },
                {
                    content: "Uspokój się. Zapal sobie szluga, kup popkorn, rozsiądź się wygodnie w pierwszym rzędzie i zobacz jaki przygotowałem na tę okazję teatrzyk!",
                    character: cody
                }
            ]
        },
        task: {
            content: "Challenge: implement this funny syntax for conditional statement\nWriting ordinary if statement is boring. Your task is to implement this\nfunny looking conditional statement.\n(1 == 1).--> { puts 'true' } { puts 'false' } # should print 'true'\n (0 >= 1).--> { puts 'true' } { puts 'false' } # should print 'false'\n (0 >= 1).--> { puts 'true' }\nshould do nothing",
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
                    content: "Widzisz te kocie ruchy? To jest coś czego nigdy nie przyswoisz. Więc daj sobie spokój, wybierz jakiś prosty zawód, który udowodni przewagę czynności manualnych nad intelektem i wejdź w te tryby na sto procent.",
                    character: { name: "Robot" }
                },
                {
                    content: "Że co? Wybacz, nie dosłyszałem. Czy mógłbyś powtórzyć? Chyba słyszałem ciche pierdnięcie… albo była twój gasnący we mgle buraczany pomysł, by mnie zawstydzić",
                    character: cody
                }
            ]
        },
        task: {
            content: "Challenge: implement simple dsl language.\n\nImplement class Squirrel in a way below API will be supported.\nsquirrel = Squirrel.new\n squirrel.fight do\n jump\n kick\n punch\n jump\n end\n squirrel.actions #=> ['jump', 'kick', 'punch', 'jump']",
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
                    content: "Czołem, mały człowieczku. Sporo o tobie słyszałem. Przypomnij sobie jakie słowa chcesz zamieścić na swoim nagrobku",
                    character: { name: "Golem" }
                },
                {
                    content: "Spoko, spoko. Nie wymachuj mi tu cienkimi groźbami. Poruszę niebo i ziemię by cie stąd pozamiatać. Będziesz zwiewał do najgłębszych czeluści tej planety, a tam moi ludzie zaczają się w skalnych szczelinach, dopadną i załatwią cię ciężką amunicją",
                    character: cody
                }
            ]
        },
        task: {
            content: "Challenge: implement your own Array#find_all method\n\nI removed find_all from Array class!\nYour task is to implement your own Array#find_all method so\n[1, 2, 3, 4].find_all { |e| e > 2 } would return [3, 4].",
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
                    content: "Zabierzcie mnie no, to coś sprzed nosa! To jakieś żarty, że skarlony koto-szczur staje przed majestatem tak wielkim jak mój i ma czelność podnosić rękawicę!",
                    character: { name: "Dyktator" }
                },
                {
                    content: "Oślepłem, proszę pana. Po prostu oślepłem. Moje oczy zalała fala zażenowania tą nadętą błazenadą. Pozwolę sobie zatem pokazać co potrafię",
                    character: cody
                }
            ]
        },
        task: {
            content: "Challenge: write a program which prints 'Hello World!' on the screen.",
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
                    content: "Na początek mandacik za przekroczenie wysokości. Będzie odsiadka, jakieś 1,5 roku na nowych przepisach",
                    character: { name: "Zły policjant" }
                },
                {
                    content: "Poleciłbym ci zamienić zabawkową spluwę na prawdziwą. Późnej możemy do siebie strzelać… i jeszcze jedno. Ja to tam nie chcę nikogo zabijać. Ale jeśli będę chciał wejść na szczyt drzewa, po tym konarze, a ty staniesz mi na drodze, to tak czy owak będziesz mi musiał zejść z drogi.",
                    character: cody
                }
            ]
        },
        task: {
            content: "Challenge: convert number to string according to formatting rule\n\nWrite a method called 'format_number' which converts given integer number to string like this:\nformat_number(1234)    #=> '1_234'\nformat_number(-1234)   #=> '-1_234'\nformat_number(134567)  #=> '134_567'\nformat_number(49)      #=> '49'",
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
                    content: "Wymyśliłem do czego się idealnie nadajesz. Zrobię z ciebie balonik w kształcie małego pieska dla 3 letnich dziewczynek",
                    character: { name: "Klaun" }
                },
                {
                    content: "Chcesz kontynuować tę filozoficzną dysputę tutaj we dwójkę czy mam zawołać jeszcze lokalnych przedstawicieli grup społecznych / subkultur?",
                    character: cody
                }
            ]
        },
        task: {
            content: "Challenge: implement your own modulo operator\n\nI removed % operator for integer numbers!\nYour task is to re-implement it in that way following code will work properly:\n10 % 3 #=> 1\n23 % 0 # raises ZeroDivisionError error\nDon't worry about negative numbers. I don't use them because I don't like them.",
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
                    content: "Gdzie syneczku? Wiedziałam, że nic z ciebie nie będzie. Zawsze powtarzałam, że wyglądasz groteskowo, jak pomieszanie krzaków z jeżem. Zamiataj stąd.",
                    character: { name: "Teściowa" }
                },
                {
                    content: "Chyba mąż cię nie kocha. Wywołuje we mnie teściowa chwilowy wstręt do ludzi. Zarazą jesteś. Ale nie ze mną takie numery. Udowodnię Ci, że nie jestem tu przez przypadek.",
                    character: cody
                }
            ]
        },
        task: {
            content: "Challenge: write a method 'change_object'\n\nYour task is to implement a method 'change_object' in such a way that in following code:\n\nobject = Object.new\nchange_object(object)\n\ndef empty?(o)\no.size == 0\nend\n\nempty?(o)\n\ncalling empty?(o) would return 'Hello World!' string.",
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
                    content: "Słuchaj no, mały, będę z tobą szczery, dobra? Mam głęboko w dupie co wiesz, a czego nie. Jedyne co jest teraz ważne to zapewnienie ci chwilowej zabawy w postaci spadania w dół.",
                    character: { name: "Radioaktywny szczór" }
                },
                {
                    content: "Kurna, w ogóle nie pamiętam, abym kupował jakieś bilety do parku rozrywki. Dzięki, te sobie zatrzymam, a spadanie w dół zaraz stanie się twoim nowym doświadczeniem.",
                    character: cody
                }
            ]
        },
        task: {
            content: "Write a program which prints sentence 'Ruby was released in 1995!' on screen.\nUse can use only a-zA-Z.<space><new line> (small & big letters, dot, space and new line)\ncharacters in your source code.",
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
                    content: "Słuchaj no, mały, będę z tobą szczery, dobra? Mam głęboko w dupie co wiesz, a czego nie. Jedyne co jest teraz ważne to zapewnienie ci chwilowej zabawy w postaci spadania w dół.",
                    character: { name: "Myśliwy" }
                },
                {
                    content: "Kurna, w ogóle nie pamiętam, abym kupował jakieś bilety do parku rozrywki. Dzięki, te sobie zatrzymam, a spadanie w dół zaraz stanie się twoim nowym doświadczeniem.",
                    character: cody
                }
            ]
        },
        task: {
            content: "Challenge\n\nHere is the funny method I wrote once:\n\ndef ruby_love\nWe ♥ Ruby! What about you?\nend\n\n This method should return 'I ♥ Ruby too!' string. You can't change 'ruby_love' method at all.",
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

