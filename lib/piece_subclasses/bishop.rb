
class Bishop < Piece

  def initialize(color)
    @color = color
  end

  def to_s
    if color == 'white'
      '♝'
    else
      '♗'
    end
  end

  def moves
    [[1,1],[1,-1],[-1,-1],[-1,1]]
  end
end
