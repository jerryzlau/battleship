class HumanPlayer

  attr_reader :name

  def initialize(name="Player")
    @name = name
  end

  def get_play
    puts "Where do you want to attack. ex. x,y"
    pos = gets.chomp
    pos.split(",").map(&:to_i)
  end

end
