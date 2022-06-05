
class Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
    NotImplementedError
  end

  def white?
    color == 'white' ? true : false
  end

  def black?
    color == 'black' ? true : false
  end

  def same_team?(player1_turn)
    if white?
      player1_turn ? true : false
    elsif black?
      player1_turn ? false : true
    elsif color.nil?
      false
    end
  end

  def enemy_team?(player1_turn)
    if white?
      player1_turn ? false : true
    elsif black?
      player1_turn ? true : false
    elsif color.nil?
      false
    end
  end

  def self.piece_for(color, piece)
    piece.new(color)
  end

  def moves
    NotImplementedError
  end
end