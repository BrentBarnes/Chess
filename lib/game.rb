
require_relative 'main'

class Game

  attr_accessor :turn
  attr_reader :board, :move_manager, :ui, :graveyard, :check_manager

  def initialize
    @graveyard = Graveyard.new(self)
    @board = Board.new(self, graveyard, move_manager)
    @move_manager = MoveManager.new(self, board)
    @check_manager = CheckManager.new(self, board, move_manager)
    @ui = UI.new(self, board, move_manager, check_manager)
    @turn = 1
  end

  def play
    loop do
      set_up_game
      execute_turn until check_manager.active_team_checkmate?
      rematch = ui.game_over_sequence
      rematch ? Game.new.play : break
    end
    puts "Thanks for playing!"
  end

  def set_up_game
    board.set_up_board
    ui.introduction
    loop do
      response = gets.chomp
      break if response.to_i == 1
    end
  end

  def execute_turn
    system("clear")
    board.print_board
    ui.move_piece
    @turn += 1
  end

  def cell_at(coordinate)
    board.board.flatten.find { |space| space.name == coordinate }
  end

  def valid_moves_for(cell_object)
    move_manager.valid_moves_for(cell_object)
  end

  def player1_turn?
    turn % 2 == 1 ? true : false
  end

  def active_team
    player1_turn? ? 'White' : 'Black'
  end

  def non_active_team
    player1_turn? ? 'Black' : 'White'
  end

end
