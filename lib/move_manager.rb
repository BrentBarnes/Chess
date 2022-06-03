
require_relative 'main'

class MoveManager
  attr_reader :game, :board

  def initialize(board)
    @game = Game.new
    @board = board
  end

  def all_directions
    ['up','up_right','right','down_right','down','down_left','left','up_left']
  end

  def surrounding_cells(space_object)
    cells = []

    all_directions.each do |direction|
      cells << space_object.send(direction)
    end
    cells
  end

  def convert_to_board(space_object)
    fake_cells = surrounding_cells(space_object)
    board_cells = []

    fake_cells.each do |fake_cell|
      board.board.flatten.find { |cell| board_cells << cell if cell == fake_cell }
    end
    board_cells
  end

  def valid_king_moves(space_object)
    potential = convert_to_board(space_object)
    valid_moves = []

    potential.each do |cell|
      valid_moves << cell.name unless cell.same_team_on_space?
    end
    valid_moves
  end

end