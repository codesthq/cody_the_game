# Challenge: write MagicSuperclass class to make it work without error

class Warrior < MagicSuperclass
  def initialize
    raise "haha"
  end

  def fight
    puts "fight called"
  end
end

warrior = Warrior.new
warrior.fight

