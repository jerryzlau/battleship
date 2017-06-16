class BattleshipGame
  attr_reader :board, :player

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
    target = player.get_play
    attack(target)
  end

end
