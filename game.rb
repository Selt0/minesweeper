require 'yaml'
require_relative "board"

class Minesweeper
  LAYOUTS = {
    small: {grid_size: 9, num_bombs: 10},
    medium: {grid_size: 16, num_bombs: 40},
    large: {grid_size: 32, num_bombs: 160}
}.freeze

  attr_reader :board

  def initialize(size = :small)
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

  def get_move
    pos = nil
    action_type = nil

    until pos && action_type && valid_pos?(pos) && valid_action?(action_type)
      prompt_message

      action_type, row, col = gets.chomp.split
    
      pos = [row.to_i, col.to_i]
    end
      [action_type, pos]
  end

  def prompt_message
    puts "Enter an action move followed by a position on the board (e.g., e 3 4)"
      puts
      puts "Action moves: "
      puts "'e' to explore"
      puts "'f' to flag"
      puts
      print "> "
  end

  def valid_pos?(pos)
    pos.is_a?(Array) && pos.length == 2 && pos.all?{ |x| x.between?(0, board.grid_size - 1) }
  end

  def valid_action?(action)
    action.is_a?(String) && action.length == 1 && (action == 'f' || action == 'e')
  end

  def perform_move(action_type, pos)
    tile = board[pos]

    case action_type
    when 'f'
      tile.toggle_flag
    when  'e'
      tile.explore   
    end
  end
end