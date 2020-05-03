require 'yaml'
require_relative "board"

class Minesweeper
  LAYOUTS = {
    small: {grid_size: 9, num_bombs: 10}
    medium: {grid_size: 16, num_bombs: 40}
    large: {grid_size: 32, num_bombs: 160}
}.freeze

  attr_reader :board

  def initialize(size)
    layout = LAYOUTS[size]
    @board = Board.new(layout[:grid_size], layout[:num_bombs])
  end

  def play
    until board.won? || board.lost?
      puts board.render

      action, pos = get_move
      perform_move(action, pos)
    end
    if board.won?
      puts "You win!"
    elsif board.lost?
      puts "BOMB HIT! Boooom :("
      puts board.reveal
    end
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      puts "Enter a position on the board (e.g., '3 4')"
      print "> "

      begin
        pos = parse_pos(gets.chomp)
      rescue => exception
        puts "Invalid position"
        puts ""
        
        pos = nil
      end
    end
    pos
  end

  def get_val
    val = nil
    until val && valid_val?(val)
      puts "Enter your choice to either reveal('r') or flag('f')"
      print "> "

      begin
        val = gets.chomp
      rescue => exception
        puts "Invalid options"
        puts ""

        val = nil
      end
    end
    val
  end

  def parse_pos(pos)
    pos.split.map{ |char| Integer(char) }
  end

  def valid_pos?(pos)
    pos.is_a?(Array) && pos.length == 2 && pos.all?{ |x| x.between?(0, @grid_size - 1) }
  end

  def valid_val?(val)
    val.is_a?(String) && val.length == 1 && (val == 'f' || val == 'r')
  end
end