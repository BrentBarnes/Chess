
require_relative '../lib/main'

describe Cell do

  describe '#empty?' do
    let(:game) { Game.new }
    subject(:cell) { described_class.new(6, 3, game, Board.new(game, game.move_manager)) }
    context 'when a space is empty' do
      it 'returns true' do
        expect(cell.empty?).to be true
      end
    end
    
    context 'when a space is not empty' do
      it 'returns false' do
        cell.content = 'not empty'
        expect(cell.empty?).to be false
      end
    end
  end

  describe '#in_bounds?' do
    let(:game) { Game.new }
    context 'when coordinate is in bounds' do
      subject(:cell) { described_class.new(5,5, game, Board.new(game, game.move_manager)) }
      it 'returns true' do
        expect(cell.in_bounds?).to eq(true)
      end
    end

    context 'when coordinate is not bounds' do
      subject(:cell) { described_class.new(20,13, game, Board.new(game, game.move_manager)) }
      it 'returns false' do
        expect(cell.in_bounds?).to eq(false)
      end
    end
  end

  describe '#out_of_bounds?' do
    let(:game) { Game.new }
    context 'when coordinate is not bounds' do
      subject(:cell) { described_class.new(20,13, game, Board.new(game, game.move_manager)) }
      it 'returns false' do
        expect(cell.out_of_bounds?).to eq(true)
      end
    end

    context 'when coordinate is in bounds' do
      subject(:cell) { described_class.new(5,5, game, Board.new(game, game.move_manager)) }
      it 'returns true' do
        expect(cell.out_of_bounds?).to eq(false)
      end
    end
  end

  describe '#clear_piece_and_content' do
    let(:game) { Game.new }
    subject(:cell) { described_class.new(6,3, game, Board.new(game, game.move_manager)) }
    context 'when a space with a piece is selected' do
      it 'clears the piece from that space' do
        cell.content = 'occupied'
        cell.clear_piece_and_content

        expect(cell.content).to eq('   ')
      end
    end
  end

  describe '#same_team_on_space?' do
    let(:game) { Game.new }
    subject(:cell) { described_class.new(6,3, game, Board.new(game, game.move_manager)) }
    
    context 'when the same team piece is on the space' do
      it 'returns true' do
        cell.instance_variable_set(:@piece, Pawn.new('white'))
        expect(cell.same_team_on_space?).to eq(true)
      end
    end

    context 'when the enemy team piece is on the space' do
      it 'returns false' do
        cell.instance_variable_set(:@piece, Pawn.new('black'))
        expect(cell.same_team_on_space?).to eq(false)
      end
    end
  end

  describe '#enemy_team_on_space?' do
    let(:game) { Game.new }
    subject(:cell) { described_class.new(6,3, game, Board.new(game, game.move_manager)) }
    
    context 'when the enemy team piece is on the space' do
      it 'returns true' do
        cell.instance_variable_set(:@piece, Pawn.new('black'))
        expect(cell.enemy_team_on_space?).to eq(true)
      end
    end

    context 'when the same team piece is on the space' do
      it 'returns false' do
        cell.instance_variable_set(:@piece, Pawn.new('white'))
        expect(cell.enemy_team_on_space?).to eq(false)
      end
    end
  end

  describe '#knight_cells' do
    let(:game) { Game.new }
    let(:board) { Board.new(game, game.move_manager) }
    context 'when the piece is a Knight on space d3' do
      subject(:cell) { described_class.new(5,3, game, board) }
      it 'returns all potential cells that a knight could move' do
        cell.piece = Knight.new('white')
        moves = ['e5','f4','f2','e1','c1','b2','b4','c5']
        cells = strings_to_cells(moves)
        expect(cell.knight_cells).to eq(cells)
      end
    end

    context 'when the piece is a Knight on space b1' do
      subject(:cell) { described_class.new(7,1, game, board) }
      it 'returns all potential cells that a knight could move' do
        cell.piece = Knight.new('white')
        moves = ['c3','d2','a3']
        cells = strings_to_cells(moves)
        expect(cell.knight_cells).to eq(cells)
      end
    end
  end
  
  describe '#pawn_cells' do
    let(:game) { Game.new }
    let(:board) { Board.new(game, game.move_manager) }
    context 'when the piece is a Pawn on space d2' do
      subject(:d2) { described_class.new(6, 3, game, board) }
      it 'returns all 4 possible moves' do
        moves = ['d3','d4','c3','e3']
        cells = strings_to_cells(moves)
        expect(d2.pawn_cells).to eq(cells)
      end
    end

    context 'when the piece is a Pawn on space h2' do
      subject(:h2) { described_class.new(6,7, game, board) }
      it 'returns all 3 possible moves' do
        moves = ['h3','h4','g3']
        cells = strings_to_cells(moves)
        expect(h2.pawn_cells).to eq(cells)
      end
    end
  end
end


#Helper Methods

def set_piece(color, piece_type, coordinate)
  piece = Piece.piece_for(color, piece_type)
  board.place_piece(piece, coordinate)
end

def strings_to_cells(strings)
  strings.filter_map { |coordinate| board.cell_at(coordinate) }
end