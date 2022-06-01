
class EmptySpace < Piece

  def initialize(color)
    @color = nil
  end

  def to_s
    ' '
  end

  def moves
    nil
  end
end