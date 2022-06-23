
class Graveyard

  attr_accessor :white_graveyard, :black_graveyard

  def initialize(game)
    @game = game
    @white_graveyard = []
    @black_graveyard = []
  end

  def send_piece_to_graveyard(piece)
    if piece.color == 'white'
      @white_graveyard << piece.to_s
    elsif piece.color == 'black'
      @black_graveyard << piece.to_s
    end
  end

  def display_graveyard(color)
    if color == 'white'
      puts "                              #{white_graveyard.join(' ')}"
    else
      puts "                              #{black_graveyard.join(' 0')}"
    end
  end
end