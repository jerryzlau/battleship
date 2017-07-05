class Board

  attr_accessor :grid

  def initialize(grid= Board.default_grid)
    @grid = grid
  end

  def self.default_grid
    @grid = Array.new(10) {Array.new(10)}
  end

  def [](pos)
    x = pos.first
    y = pos.last
    @grid[x][y]
  end

  def []=(pos, mark)
    x = pos.first
    y = pos.last
    @grid[x][y] = mark
  end

  def count
    self.grid.flatten.select {|el| !el.nil? }.size
  end

  def empty?(pos= nil)
    return true if self.count == 0
    return false if pos.nil?

    x = pos.first
    y = pos.last
    self.grid[x][y].nil?
  end

  def full?
    self.count == self.grid.flatten.size
  end

  def display
    print "-" * @grid.length * 5
    puts ""
    @grid.each do |row|
      row.each do |pos|
        if pos == :s || pos.nil?
          print "|   |"
        elsif !pos.nil?
          print "| #{pos} |"
        end
      end
      print "\n"
    end
    print "-" * @grid.length * 5
    print "\n"
  end

  def reveal
    print "-" * @grid.length * 5
    puts ""
    @grid.each do |row|
      row.each do |pos|
        if !pos.nil?
          print "| #{pos} |"
        else
          print "|   |"
        end
      end
      print "\n"
    end
    print "-" * @grid.length * 5
    print "\n"
  end

  def place_random_ship
    raise "board is full!" if full?
    length = @grid.size-1
    x = rand(0..length)
    y = rand(0..length)
    @grid[x][y] = :s if self.empty?([x,y])
  end

  def won?
    self.grid.flatten.select {|el| el == :s}.count == 0
  end

end
