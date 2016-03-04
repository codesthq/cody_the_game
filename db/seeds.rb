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
  { name: "Wściekły pies" },
  { name: "Czarownica" },
  { name: "Robot" },
  { name: "Golem" },
  { name: "Dyktator" },
  { name: "Zły policjant" },
  { name: "Klaun" },
  { name: "Teściowa" },
  { name: "Radioaktywny szczór" },
  { name: "Myśliwy" }
]

levels = [
  { name: "Mad dog level", description: "Mad dog question" },
  { name: "Witch level", description: "Witch question" },
  { name: "Robot level", description: "Robots question" },
  { name: "Golem's level", description: "Golem question" },
  { name: "Dictator suicide", description: "Dictator question" },
  { name: "Bad cop on trees", description: "Bad cop question" },
  { name: "Clown", description: "Clown question" },
  { name: "Mother-in-law suicide", description: "Mother-in-law question" },
  { name: "Radioactive rat", description: "Radioactive rat question" },
  { name: "Hunter", description: "Hunter question" }
]

tasks = [
  { content: "I have a funny case for you!\nWrite such a code that allows to use ~:foo syntax in 'case' statement like this:\n\nany_object = []\ncase any_object\nwhen ~:foo\n  # any_object responds to :foo method\nwhen ~:size\n  # any_object responds to :size method\nelse\nend", points: 2, start_code: "What do you think, hmm?" },
  { content: "Are eyebrows considered facial hair?", points: 1 },
  { content: "Why are there no 'B' batteries? ", points: 2 },
  { content: "How do you handcuff a one-armed man?", points: 3 },
  { content: "Can animals commit suicide?", points: 4 },
  { content: "If money doesn't grow on trees then why do banks have branches?", points: 2 },
  { content: "What's the difference between normal ketchup and fancy ketchup?", points: 5, start_code: "Just ketchup" },
  { content: "What does it mean to dod?", points: 8 },
  { content: "Another hehe question stuff", points: 6 },
  { content: "What's the difference between normal ketchup and fancy ketchup?", points: 1, start_code: "def setup; puts 'hehe'; end" }
]

conversations = [
  [
    { content: "O czym ja to mówiłem? Aaa! Las donosi, że jakiś cienki troll próbuje się dostać na szczyt. Zabieraj lepiej ten plecaczek i wracaj pokodować w logomocji*“. Dwa kroki w tył. Potem prosto w doł i już jesteś w miejscu przeznaczenia." },
    { content: "Będziesz tak szczekał pieseczku, czy będziesz gryzł?. Będę robił co mi się, cholera / kurka wodna/ motyla noga / proszę ja ciebie/  zachce" }
  ],

  [
    { content: "To jest codekiller? To jest jakaś popierdółka a nie codekiller!“ CODY - PARODY!" },
    { content: "Uspokój się. Zapal sobie szluga, kup popkorn, rozsiądź się wygodnie w pierwszym rzędzie i zobacz jaki przygotowałem na tę okazję teatrzyk!" }
  ],

  [
    { content: "Widzisz te kocie ruchy? To jest coś czego nigdy nie przyswoisz. Więc daj sobie spokój, wybierz jakiś prosty zawód, który udowodni przewagę czynności manualnych nad intelektem i wejdź w te tryby na sto procent." },
    { content: "Że co? Wybacz, nie dosłyszałem. Czy mógłbyś powtórzyć? Chyba słyszałem ciche pierdnięcie… albo była twój gasnący we mgle buraczany pomysł, by mnie zawstydzić" }
  ],

  [
      { content: "Czołem, mały człowieczku. Sporo o tobie słyszałem. Przypomnij sobie jakie słowa chcesz zamieścić na swoim nagrobku" },
      { content: "Spoko, spoko. Nie wymachuj mi tu cienkimi groźbami. Poruszę niebo i ziemię by cie stąd pozamiatać. Będziesz zwiewał do najgłębszych czeluści tej planety, a tam moi ludzie zaczają się w skalnych szczelinach, dopadną i załatwią cię ciężką amunicją" }
  ],

  [
      { content: "Zabierzcie mnie no, to coś sprzed nosa! To jakieś żarty, że skarlony koto-szczur staje przed majestatem tak wielkim jak mój i ma czelność podnosić rękawicę!" },
      { content: "Oślepłem, proszę pana. Po prostu oślepłem. Moje oczy zalała fala zażenowania tą nadętą błazenadą. Pozwolę sobie zatem pokazać co potrafię" }
  ],

  [
      { content: "Na początek mandacik za przekroczenie wysokości. Będzie odsiadka, jakieś 1,5 roku na nowych przepisach" },
      { content: "Poleciłbym ci zamienić zabawkową spluwę na prawdziwą. Późnej możemy do siebie strzelać… i jeszcze jedno. Ja to tam nie chcę nikogo zabijać. Ale jeśli będę chciał wejść na szczyt drzewa, po tym konarze, a ty staniesz mi na drodze, to tak czy owak będziesz mi musiał zejść z drogi." }
  ],

  [
      { content: "Wymyśliłem do czego się idealnie nadajesz. Zrobię z ciebie balonik w kształcie małego pieska dla 3 letnich dziewczynek" },
      { content: "Chcesz kontynuować tę filozoficzną dysputę tutaj we dwójkę czy mam zawołać jeszcze lokalnych przedstawicieli grup społecznych / subkultur?" }
  ],

  [
      { content: "Gdzie syneczku? Wiedziałam, że nic z ciebie nie będzie. Zawsze powtarzałam, że wyglądasz groteskowo, jak pomieszanie krzaków z jeżem. Zamiataj stąd." },
      { content: "Chyba mąż cię nie kocha. Wywołuje we mnie teściowa chwilowy wstręt do ludzi. Zarazą jesteś. Ale nie ze mną takie numery. Udowodnię Ci, że nie jestem tu przez przypadek." }
  ],

  [
      { content: "Słuchaj no, mały, będę z tobą szczery, dobra? Mam głęboko w dupie co wiesz, a czego nie. Jedyne co jest teraz ważne to zapewnienie ci chwilowej zabawy w postaci spadania w dół." },
      { content: "Kurna, w ogóle nie pamiętam, abym kupował jakieś bilety do parku rozrywki. Dzięki, te sobie zatrzymam, a spadanie w dół zaraz stanie się twoim nowym doświadczeniem." }
  ],

  [
      { content: "Słuchaj no, mały, będę z tobą szczery, dobra? Mam głęboko w dupie co wiesz, a czego nie. Jedyne co jest teraz ważne to zapewnienie ci chwilowej zabawy w postaci spadania w dół." },
      { content: "Kurna, w ogóle nie pamiętam, abym kupował jakieś bilety do parku rozrywki. Dzięki, te sobie zatrzymam, a spadanie w dół zaraz stanie się twoim nowym doświadczeniem." }
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
