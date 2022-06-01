
class Game

  attr_reader :board, :turn

  def initialize(board)
    @main = Main.new
    @board = board
    @turn = 1
  end

  def get_start_position
    selection = gets.chomp
    space = board.space_at(selection)
    piece = space.piece
    binding.pry
    if !piece.same_team?(player1_turn?)
      puts 'Select a valid coordinate (a-h, 1-8)'
      get_start_position
    end
    selection
  end

  def player1_turn?
    turn % 2 == 1 ? true : false
  end

end
