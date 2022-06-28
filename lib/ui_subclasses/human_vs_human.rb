
class HumanVsHuman < UI
  attr_reader :game, :move_manager, :check_manager
  attr_accessor :board

  def initialize(game, board, move_manager, check_manager)
    @game = game
    @board = board
    @move_manager = move_manager
    @check_manager = check_manager
  end

  def move_piece
    human_move_piece
  end
end