require_relative "player.rb"
require_relative "board.rb"

class BattleshipGame
  attr_accessor :board
  attr_reader :player

  def initialize(player, board)
    @player = player
    @board = board
    @counter = 0
  end

  def attack(pos)
    x, y = pos.first, pos.last
    if @board.grid[x][y] == :s
      @board.grid[x][y] = "\e[5m\e[41m*\e[25m\e[49m"
      p @counter += 1
    else
      @board.grid[x][y] = :w
    end
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
      #@board.reveal
      play_turn
    end
    @board.reveal
    puts "Congrats #{player.name}! You have won!"
  end


end

if $0 == __FILE__
  board = Board.new
  5.times {board.place_random_ship(3)}
  player = ComputerPlayer.new
  #player = HumanPlayer.new
  battleship = BattleshipGame.new(player,board)
  battleship.play
end
