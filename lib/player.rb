class HumanPlayer

  def initialize(name)
    @name = name
  end

  def get_play
    print "Where do you want to attack. ex. [x,y]"
    pos = gets.chomp
  end
  
end
