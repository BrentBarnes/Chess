
class EmptySpace < Piece

  def initialize(color=nil)
    @color = nil
  end

  def to_s
    ' '
  end

  def moves
    nil
  end
end