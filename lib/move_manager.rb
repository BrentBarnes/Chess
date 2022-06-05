
require_relative 'main'

class MoveManager
  attr_reader :game, :board

  def initialize(board)
    @game = Game.new
    @board = board
  end

  def all_directions
    [:up, :up_right, :right, :down_right, :down, :down_left, :left, :up_left]
  end

  def surrounding_cells(cell_object)
    cells = []

    all_directions.each do |direction|
      cells << cell_object.send(direction)
    end
    cells
  end

  def valid_king_moves(cell_object)
    potential = surrounding_cells(cell_object)
    valid_moves = []

    potential.each do |cell|
      unless cell.nil? || cell.same_team_on_space?
        valid_moves << cell.name
      end
    end
    valid_moves
  end

  def valid_queen_moves(cell_object)
    valid_moves = []
    
    all_directions.each do |direction|
      valid_moves << valid_moves_in_direction(cell_object, direction)
    end
    valid_moves.flatten
  end

  def valid_rook_moves(cell_object)
    valid_moves = []
    directions = [:up, :right, :down, :left]

    directions.each do |direction|
      valid_moves << valid_moves_in_direction(cell_object, direction)
    end
    valid_moves.flatten
  end

  def valid_knight_moves(cell_object)
    valid_moves = []
    potential_cells = cell_object.knight_cells

    potential_cells.each do |cell|
      unless cell.nil? || cell.same_team_on_space?
        valid_moves << cell.name
      end
    end
    valid_moves
  end

  def valid_bishop_moves(cell_object)
    valid_moves = []
    directions = [:up_right, :down_right, :down_left, :up_left]
    
    directions.each do |direction|
      valid_moves << valid_moves_in_direction(cell_object, direction)
    end
    valid_moves.flatten
  end

  def valid_moves_in_direction(cell_object, direction)
    valid_moves = []
    next_cell = cell_object.send(direction)

    loop do
      break if next_cell.nil?
      break if next_cell.same_team_on_space?
      valid_moves << next_cell.name
      break if next_cell.enemy_team_on_space?
      next_cell = next_cell.send(direction)
    end
    valid_moves
  end

end