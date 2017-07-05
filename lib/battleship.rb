require_relative "player.rb"
require_relative "board.rb"

class BattleshipGame
  attr_accessor :board
  attr_reader :player

  def initialize(player, board)
    @player = player
    @board = board
  end

  def attack(pos)
    x, y = pos.first, pos.last
    @board.grid[x][y] = :x
  end

  def count
    @board.count
  end

  def game_over?
    @board.won?
  end

  def play_turn
    target = @player.get_play
    attack(target)
  end

  def play
    until game_over?
      @board.display
      play_turn
    end
    puts "Congrats #{player.name}! You have won!"
  end

end

if $0 == __FILE__
  board = Board.new
  5.times {board.place_random_ship}
  player = HumanPlayer.new("Jerry")
  battleship = BattleshipGame.new(player,board)
  battleship.play
end
