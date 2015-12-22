# Challenge: implement simple dsl language

squirrel = Squirrel.new
squirrel.fight do
  jump
  kick
  punch
end

squirrel.actions #=> ["jump", "kick", "punch"]


