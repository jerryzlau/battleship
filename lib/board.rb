class Board

  attr_reader :grid

  def initialize(grid= Board.default_grid)
    @grid = grid
  end

  def self.default_grid
    @grid = []
    row = Array.new(10)
    10.times {@grid << row}
    @grid
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(x, y, mark)
    @grid[x][y] = mark
  end

  def count
    self.grid.flatten.select {|el| !el.nil? }.size
  end

  def empty?(pos= nil)
    return true if self.count == 0
    return false if pos.nil?

    x, y = pos.first, pos.last
    self.grid[x][y].nil?
  end

  def full?
    self.count == self.grid.flatten.size
  end

  def place_random_ship
    raise "board is full!" if self.full?
    length = self.grid.size-1
    x = rand(0..length)
    y = rand(0..length)
    self.grid[x][y] = :s if self.empty?([x,y])
  end

  def won?
    self.grid.flatten.select {|el| el == :s}.count == 0
  end

end
