require "byebug"

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

  # def place_random_ship
  #     raise "board is full!" if full?
  #     length = @grid.size-1
  #     ship_size = [5,4,3,2].sample
  #     x = rand(0..length)
  #     y = rand(0..length)
  #     @grid[x][y] = :s if self.empty?([x,y])
  # end
  #
  # def build_ship(x,y,ship_size)
  #   direction = ["n", "w", "s", "e"].sample
  #
  #   #check if it's out of bound
  #
  #   #check if it's overlaying other ships
  #
  # end


  def place_random_ship(size=2)
    raise "board is full!" if full?
    length = @grid.size-1
    reverse_counter = 0
    x = rand(0..length)
    y = rand(0..length)
    orientation = ["N", "W", "S", "E"].sample

    #border check
    if orientation == "N"
      orientation = "S" if y + size - 1 > length
    elsif orientation == "S"
      orientation = "N" if y - size - 1 < 0
    elsif orientation == "E"
      orientation = "W" if x + size - 1 > length
    else
      orientation = "E" if x - size - 1 < 0
    end



    #make the ships
    if orientation == "E"
      (0..size-1).each do |increment|
        if self.empty?([x+increment,y])
          @grid[x+increment][y] = :s
        elsif @grid[x+increment][y] == :s
          reverse_counter += 1
          @grid[x-reverse_counter][y] = :s
        end
      end
      reverse_counter = 0
    elsif orientation == "W"
      (0..size-1).each do |increment|
        # @grid[x-increment][y] = :s if self.empty?([x-increment,y])
        if self.empty?([x-increment,y])
          @grid[x-increment][y] = :s
        elsif @grid[x-increment][y] == :s
          reverse_counter += 1
          @grid[x+reverse_counter][y] = :s
        end
      end
      reverse_counter = 0
    elsif orientation == "N"
      (0..size-1).each do |increment|
        # @grid[x][y+increment] = :s if self.empty?([x,y+increment])
        if self.empty?([x,y+increment])
          @grid[x][y+increment] = :s
        elsif @grid[x][y+increment] == :s
          reverse_counter += 1
          @grid[x][y-reverse_counter] = :s
        end
      end
      reverse_counter = 0
    elsif orientation == "S"
      (0..size-1).each do |increment|
        # @grid[x][y-increment] = :s if self.empty?([x,y-increment])
        if self.empty?([x,y-increment])
          @grid[x][y-increment] = :s
        elsif @grid[x][y-increment] == :s
          reverse_counter += 1
          @grid[x][y+reverse_counter] = :s
        end
      end
      reverse_counter = 0
    end
  end

  def won?
    self.grid.flatten.select {|el| el == :s}.count == 0
  end

end

# if $0 == __FILE__
#   board = Board.new
#   5.times do
#     ship_size = [1,2,3,4,5].sample
#     board.make_ship(ship_size)
#   end
#   board.reveal
# end
