
class Knight < Piece

  def initialize(color)
    @color = color
  end

  def to_s
    if color == 'white'
      '♞'
    else
      '♘'
    end
  end

  def directions
    [[1,-2],[2,-1],[2,1],[1,2][-1,-2],[-2,-1],[-2,1],[-1,2]]
  end
end
