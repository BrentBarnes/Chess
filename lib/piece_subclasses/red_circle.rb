
class RedCircle < Piece

  def initialize(color)
    @color = 'red'
  end

  def to_s
    '⏺'.colorize(:red)
  end

  def directions

  end
end
