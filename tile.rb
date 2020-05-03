
class Tile
  NEIGHBORS = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [0,  -1],
    [0,   1],
    [1,  -1],
    [1,   0],
    [1,   1]
].freeze

  attr_reader :pos

  def initialize(board, pos)
    @board, @pos = board, pos
    @bombed, @explored, @flagged = false, false, false
  end

  def bombed?
    @bombed
  end

  def explored?
    @explored
  end

  def flagged?
    @flagged
  end

  def neighbors
    adjacent_coords = NEIGHBORS.map do |(dx, dy)|
      [pos[0] + dx, pos[1] + dy]
    end.select do |row, col|
      [row, col].all? do |coord|
        coord.between?(0, @board.grid_size - 1)
      end
    end

    adjacent_coords.map { |pos| @board[pos] }
  end

  def neighbors_bomb_count
    neighbors.select(&:bombed?).count
  end

  def explore
    #don't reveal a flagged tile
    return self if flagged?
    #don't reveal an already revealed tile
    return self if explored?

    @explored = true
    if !bombed? && neighbors_bomb_count == 0
      neighbors.each(&:explore)
    end

    self
  end

  def inspect
    { pos: pos,
    bombed: bombed?,
    flagged: flagged?,
    exlpored: explored? }.inspect
  end

  def plant_bomb
    @bombed = true
  end

  def render
    if flagged?
      "F"
    elsif explored?
      neighbors_bomb_count == 0 ? " " : neighbors_bomb_count.to_s
    else
      "_"
    end
  end

  def reveal
    if flagged?
      #mark true and false flags
      bombed? ? "F" : 'f'
    elsif bombed?
      #mark X if bomb is revealed
      explored? ? "X" : :B
    else 
      #display numbers if near bomb
      neighbors_bomb_count == 0 ? " " : neighbors_bomb_count.to_s
    end
  end

  def toggle_flag
    #ignore explored squares
    @flagged = !@flagged unless @explored
  end
end