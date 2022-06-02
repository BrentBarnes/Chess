
class Pawn < Piece

  def initialize(color)
    @color = color
  end

  def to_s
    if color == 'white'
      '♟'
    else
      '♙'
    end
  end

  def directions

  end
end
