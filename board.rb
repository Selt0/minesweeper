require_relative "tile"

class Board
  attr_reader :grid_size, :num_bombs, :grid

  def initialize(grid_size, num_bombs)
    @grid_size, @num_bombs = grid_size, num_bombs

    generate_board
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def render(reveal = false)
     rendered = @grid.map.with_index do |row,idx|
       row.map do |tile|
        reveal ? tile.reveal : tile.render
      end.join(' ')
    end.join("\n")
    puts "  #{(0..8).to_a.join(' ')}"
    rendered.each_line.with_index{ |row, idx| puts "#{idx} #{row}" }
    return
  end

  def reveal
    render(true)
  end

  def won?
    @grid.flatten.all? { |tile| tile.bombed? != tile.explored?}
  end

  def lost?
    @grid.flatten.any? { |tile| tile.bombed? && tile.explored? }
  end

  private

  def generate_board
    @grid = Array.new(grid_size) do |row|
      Array.new(grid_size) { |col| Tile.new(self, [row, col]) }
    end
    plant_bombs
  end

  def plant_bombs
    total_bombs = 0
    while total_bombs < num_bombs
      rand_pos = Array.new(2) { rand(grid_size) }

      tile = self[rand_pos]
      next if tile.bombed?
      
      tile.plant_bomb
      total_bombs += 1
    end
    nil
  end
end