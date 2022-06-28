
class ComputerVsComputer < UI
  attr_reader :game, :move_manager, :check_manager
  attr_accessor :board

  def initialize(game, board, move_manager, check_manager)
    @game = game
    @board = board
    @move_manager = move_manager
    @check_manager = check_manager
  end

  def move_piece
    computer_move_piece
  end

  # def game_over_sequence
  #   system('clear')
  #   board.print_board
  #   game_over_text
  # end

  # def game_over_text
  #   if check_manager.draw?
  #     puts
  #     puts "It was a draw!"
  #   else
  #     puts
  #     puts "Game Over! #{game.non_active_team} Wins!"
  #   end
  # end
end