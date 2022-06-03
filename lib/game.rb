
require_relative 'main'

class Game

  attr_reader :turn

  def initialize
    @turn = 1
  end

  # def get_start_position
  #   selection = gets.chomp
  #   space = board.space_at(selection)
  #   piece = space.piece
  #   if !piece.same_team?(player1_turn?)
  #     puts 'Select a valid coordinate (a-h, 1-8)'
  #     get_start_position
  #   end
  #   selection
  # end

  def player1_turn?
    turn % 2 == 1 ? true : false
  end

end
