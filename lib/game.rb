
require_relative 'main'

class Game

  attr_accessor :turn
  attr_reader :board, :move_manager

  def initialize
    @board = Board.new(self)
    @move_manager = MoveManager.new(self)
    @turn = 1
  end

  def player1_turn?
    turn % 2 == 1 ? true : false
  end

end
