
class Vehicle
  attr_reader :color

  def initialize(color)
    @color = color
  end
  
  
  def accelerate
    raise NotImplementedError
  end
  
  def decelerate
    raise NotImplementedError
  end

  def repaint
    @color = color
  end

  def self.make_car(color)
    Car.new(color)
  end
end

class Bike < Vehicle
  attr_reader :fixed

  def initialize(color, fixed: true)
    super(color)
    @fixed = fixed
  end

  def accelerate
    puts 'I am pedalling harder!'
  end

  def decelerate
    puts 'Only one hand break, watch out!'
  end

  def ring_bell
    puts 'Ring ring ring!'
  end
end

class Car < Vehicle
  attr_reader :engine

  def initialize(color, engine = 'V6')
    super(color)
    @engine = engine
  end

  def accelerate
    puts "Vroom Vroom!"
  end

  def decellerate
    puts "hitting the breaks"
  end

  def harzards
    puts "Hazards on!"
  end
end

def prompt_pick_piece
  active_string = @game.active == :white ? 'White' : 'Black'
  puts "You can enter 'save' to save the current game, or 'exit' to stop the program."
  puts 'Your king is under attack!' if @game.checkmate_manager.check?
  loop do
    print "#{active_string}, pick a piece to play using Chess notation: "
    input = gets.chomp.downcase
    return 'save' if input == 'save'
    return 'exit' if input == 'exit'

    cell = @game.cell(input)
    puts 'This destination is out of bounds.' if cell.nil?
    next if cell.nil?

    puts 'This destination is empty.' if cell.empty?
    next if cell.empty?

    piece_color = cell.piece.color
    owned = piece_color == @game.active
    puts 'This piece is not yours.' unless owned
    next unless owned

    avail_moves = @game.move_manager.legal_moves(cell).length
    puts 'This piece has no legal moves.' unless owned && avail_moves.positive?
    return cell if owned && avail_moves.positive?
  end
end

#inject main.rb into each class so that they have a bigger class in common