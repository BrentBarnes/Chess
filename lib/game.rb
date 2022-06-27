
require_relative 'main'

class Game

  attr_accessor :turn, :board_fen
  attr_reader :board, :move_manager, :ui, :graveyard, :check_manager

  def initialize(graveyard: Graveyard.new(self),
                board: Board.new(self, graveyard, move_manager),
                move_manager: MoveManager.new(self, board),
                check_manager: CheckManager.new(self, board, move_manager),
                ui: UI.new(self, board, move_manager, check_manager),
                turn: 1,
                board_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR') 
    @graveyard = graveyard
    @board = board
    @move_manager = move_manager
    @check_manager = check_manager
    @ui = ui
    @turn = turn
    @board_fen = board_fen
  end

  def play
    loop do
      execute_turn until check_manager.active_team_checkmate?
      rematch = ui.game_over_sequence
      rematch ? Game.new.play : break
    end
    puts "Thanks for playing!"
  end

  def execute_turn
    system("clear")
    board.print_board
    ui.move_piece
    @turn += 1
  end

  def to_json
    JSON.dump ({
      :graveyard => @graveyard,
      :board => @board,
      :move_manager => @move_manager,
      :check_manager => @check_manager,
      :ui => @ui,
      :turn => @turn,
      :board_fen => @board_fen
    })
  end

  def self.from_json(string)
    data = JSON.load string
    self.new(graveyard: data['graveyard'], board: data['board'], turn: data['turn'], board_fen: data['board_fen'])
  end

  def save_game
    @board = board.board_to_fen
    @graveyard = graveyard.save_graveyard
    save_file = File.open("save_file.txt", "w")
    save_file.write to_json
    save_file.close
  end

  def self.load_game
    file = File.open("save_file.txt", "r")
    contents = file.read
    
    self.from_json(contents)
  end

  def board_from_fen
    @board = Board.new(self, graveyard, move_manager, board)
    move_manager.board = board
    check_manager.board = board
    ui.board = board
  end

  def load_graveyard
    @graveyard = Graveyard.new(self, graveyard[0], graveyard[1])
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
