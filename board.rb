class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(9) { Array.new(9, '_') }
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    grid[x][y] = value
  end

  def place_random_bombs
    total_bombs = 10
    while self.num_bombs < total_bombs
      rand_row = rand(0...grid.length)
      rand_col = rand(0...grid.length)
      pos = [rand_row, rand_col]
      self[pos] = :B
    end
  end

  def num_bombs
    grid.flatten.count(:B)
  end

  def render(grid)
    puts "  #{(0..8).to_a.join(' ')}"
    grid.each_with_index do |row, i|
      puts "#{i} #{row.join(' ')}"
    end
  end

  def bombs_revealed
    @grid
  end

  def hidden_bombs
    @grid.map do |row|
      row.map do |ele|
        if ele == :B
          ele = '_'
        else
          ele
        end
      end
    end
  end
end