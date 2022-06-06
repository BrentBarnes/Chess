
require_relative 'main'

class MoveManager
  attr_reader :game

  def initialize(game)
    @game = game
    # @board = board
  end

  def all_directions
    [:up, :up_right, :right, :down_right, :down, :down_left, :left, :up_left]
  end

  def surrounding_cells(cell_object)
    all_directions.filter_map do |direction|
      cell_object.send(direction)
    end
  end

  def valid_king_moves(cell_object)
    potential = surrounding_cells(cell_object)

    potential.filter_map do |cell|
      cell.name unless cell.same_team_on_space?
    end
  end

  def valid_queen_moves(cell_object)
    all_directions.filter_map do |direction|
      valid_moves_in_direction(cell_object, direction)
    end.flatten
  end

  def valid_rook_moves(cell_object)
    directions = [:up, :right, :down, :left]

    directions.filter_map do |direction|
      valid_moves_in_direction(cell_object, direction)
    end.flatten
  end

  def valid_knight_moves(cell_object)
    potential_cells = cell_object.knight_cells

    potential_cells.filter_map do |cell|
      unless cell.same_team_on_space?
        cell.name
      end
    end
  end

  def valid_bishop_moves(cell_object)
    directions = [:up_right, :down_right, :down_left, :up_left]
    
    directions.filter_map do |direction|
      valid_moves_in_direction(cell_object, direction)
    end.flatten
  end

  def valid_pawn_moves(cell_object)
    valid_moves = []

    directions = cell_object.pawn_cells
    binding.pry
    conditions = [directions[0].occupied?,
                  !cell_object.pawn_home_row? || directions[0].occupied? || directions[1].occupied?,
                  directions[2].enemy_team_on_space?,
                  directions[3].enemy_team_on_space?]

    valid_moves << directions[0].name unless conditions[0]
    valid_moves << directions[1].name unless conditions[1]
    valid_moves << directions[2].name if conditions[2]
    valid_moves << directions[3].name if conditions[3]

    valid_moves
  end

  def valid_moves_in_direction(cell_object, direction)
    valid_moves = []
    next_cell = cell_object.send(direction)

    loop do
      break if next_cell.name.nil?
      break if next_cell.same_team_on_space?
      valid_moves << next_cell.name
      break if next_cell.enemy_team_on_space?
      next_cell = next_cell.send(direction)
    end
    valid_moves
  end

end