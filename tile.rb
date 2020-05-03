
class Tile
  attr_reader :value

  def initialize(value = ' ')
    @value = value
    @reveal = false
    @flagged = false
  end

  def bombed?
    value == :B
  end

  def revealed?
    @reveal
  end

  def reveal
    @reveal = true
  end

  def flagged?
    @flagged
  end

  def flag
    @flagged = true
  end

  def empty?
    @value == ' '
  end
end