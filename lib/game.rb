
require_relative 'main'

class Game

  attr_accessor :turn, :ui
  attr_reader :board, :move_manager, :graveyard, :check_manager

  def initialize(graveyard: Graveyard.new(self),
                board: Board.new(self, graveyard, move_manager),
                move_manager: MoveManager.new(self, board),
                check_manager: CheckManager.new(self, board, move_manager),
                ui: HumanVsHuman.new(self, board, move_manager, check_manager),
                turn: 1)
    @graveyard = graveyard
    @board = board
    @move_manager = move_manager
    @check_manager = check_manager
    @ui = ui
    @turn = turn
  end

  def play
    execute_turn until check_manager.active_team_checkmate? || check_manager.draw?
  end

  def rematch?
    system('clear')
    board.print_board
    ui.game_over_text

    rematch = gets.chomp.downcase
    if rematch == 'y'
      true
    else
      puts 'Thanks for playing!'
      exit
    end
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

  def to_json
    JSON.dump ({
      :graveyard => @graveyard,
      :board => @board,
      :move_manager => @move_manager,
      :check_manager => @check_manager,
      :ui => @ui,
      :turn => @turn,
    })
  end

  def self.from_json(string)
    data = JSON.load string
    self.new(graveyard: data['graveyard'], board: data['board'], turn: data['turn'])
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

  private

  def execute_turn
    system("clear")
    board.print_board
    ui.move_piece
    @turn += 1
  end
end
