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

class ComputerPlayer
  attr_reader :name

  def initialize(name="AI")
    @name = name
    @tracker = []
  end

  def get_play
    x = rand(0...10)
    y = rand(0...10)
    if !@tracker.include?([x,y])
      @tracker << [x,y]
      return [x,y]
    else
      get_play
    end
  end

end

# if $0 == __FILE__
#   board = Array.new(10) {Array.new(10)}
#   ai = ComputerPlayer.new
#   ai
# end
