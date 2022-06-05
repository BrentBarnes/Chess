
require_relative '../lib/main'

describe MoveManager do

  describe '#valid_king_moves' do
    subject(:move_manager) { described_class.new(Board.new) }
    let(:board) { Board.new }
    let(:d3) { move_manager.board.board[5][3] }
    before do
      set_piece('white', King, 'd3')
    end

    context 'when given a space containing a King piece' do
      it 'returns an array of valid moves' do
        valid_strings = ['d4','e4','e3','e2','d2','c2','c3','c4']
        cells = strings_to_cells(valid_strings)
        expect(move_manager.valid_king_moves(d3)).to eq(valid_strings)
      end
    end

    context 'when a friendly pawn is above the king' do
      it 'returns an array of valid moves excluding friendly space' do
        set_piece('white', Pawn, 'd4')
        valid_strings = ['e4','e3','e2','d2','c2','c3','c4']
        # cells = strings_to_cells(valid_strings)

        expect(move_manager.valid_king_moves(d3)).to eq(valid_strings)
      end
    end

    context 'when king is in the bottom left corner of the board a1' do
      it 'returns an array of valid moves excluding out of bounds' do
        set_piece('white', King, 'a1')
        a1 = move_manager.board.board[7][0]
        valid_strings = ['a2','b2','b1']
        # cells = strings_to_cells(valid_strings)

        expect(move_manager.valid_king_moves(a1)).to eq(valid_strings)
      end
    end
  end

  describe '#valid_rook_moves' do
    subject(:move_manager) { described_class.new(Board.new) }
    let(:board) { Board.new }
    let(:d4) { move_manager.board.board[4][3] }
    before do
      set_piece('white', Rook, 'd4')
    end

    context 'when rook is at d4 with no obstructions' do
      it 'returns all valid moves' do
        valid_moves = ['d5','d6','d7','d8','e4','f4','g4','h4','d3','d2','d1','c4','b4','a4']
        expect(move_manager.valid_rook_moves(d4)).to eq(valid_moves)
      end
    end

    context 'when rook is at d4 with obstructions' do
      it 'returns all valid moves' do
        set_piece('white', Pawn,'d7')
        set_piece('black', Pawn,'g4')
        set_piece('black', Pawn,'d3')
        set_piece('white', Pawn,'c4')
        valid_moves = ['d5','d6','e4','f4','g4','d3']
        expect(move_manager.valid_rook_moves(d4)).to eq(valid_moves)
      end
    end
  end

  describe '#valid_knight_moves' do
    subject(:move_manager) { described_class.new(Board.new) }
    let(:board) { Board.new }
    let(:d3) { move_manager.board.board[5][3] }
    before do
      set_piece('white', Knight, 'd3')
    end

    context 'when given a space containing a Knight piece' do
      it 'returns an array of valid moves' do
        valid_moves = ['e5','f4','f2','e1','c1','b2','b4','c5']
        # cells = strings_to_cells(valid_strings)
        expect(move_manager.valid_knight_moves(d3)).to eq(valid_moves)
      end
    end

    context 'when obstacles block Knight spaces' do
      xit 'returns an array of valid moves excluding obstacles' do
        set_piece('white', Pawn,'c6')
        set_piece('white', Pawn,'b3')
        set_piece('black', Pawn,'e6')
        set_piece('black', Pawn,'f3')
        valid_moves = ['e6','f5','f3','e2','c2','b5']
        # cells = strings_to_cells(valid_strings)

        expect(move_manager.valid_knight_moves(d3)).to eq(valid_moves)
      end
    end
  end

  describe '#valid_bishop_moves' do
    subject(:move_manager) { described_class.new(Board.new) }
    let(:board) { Board.new }
    let(:d4) { move_manager.board.board[4][3] }
    before do
      set_piece('white', Bishop, 'd4')
    end

    context 'when bishop is at d4 with no obstructions' do
      it 'returns all valid moves' do
        valid_moves = ['e5','f6','g7','h8','e3','f2','g1','c3','b2','a1','c5','b6','a7']
        expect(move_manager.valid_bishop_moves(d4)).to eq(valid_moves)
      end
    end

    context 'when bishop is at d4 with obstructions' do
      it 'returns all valid moves' do
        set_piece('black', Pawn,'f6')
        set_piece('white', Pawn,'f2')
        set_piece('black', Pawn,'a1')
        set_piece('white', Pawn,'c5')
        valid_moves = ['e5','f6','e3','c3','b2','a1']
        expect(move_manager.valid_bishop_moves(d4)).to eq(valid_moves)
      end
    end
  end

  describe '#valid_queen_moves' do
    subject(:move_manager) { described_class.new(Board.new) }
    let(:board) { Board.new }
    let(:d4) { move_manager.board.board[4][3] }
    before do
      set_piece('white', Queen, 'd4')
    end

    context 'when queen is at d4 with no obstructions' do
      it 'returns all valid moves' do
        valid_moves = [
          'd5','d6','d7','d8','e5','f6','g7','h8','e4','f4','g4','h4',
          'e3','f2','g1','d3','d2','d1','c3','b2','a1','c4','b4','a4',
          'c5','b6','a7'
        ]
        expect(move_manager.valid_queen_moves(d4)).to eq(valid_moves)
      end
    end

    context 'when queen is at d4 with obstructions' do
      it 'returns all valid moves' do
        set_piece('white', Pawn,'d7')
        set_piece('white', Pawn,'g7')
        set_piece('black', Pawn,'g4')
        set_piece('black', Pawn,'e3')
        set_piece('black', Pawn,'d3')
        set_piece('white', Pawn,'a1')
        set_piece('white', Pawn,'c4')
        set_piece('black', Pawn,'b6')
        valid_moves = [
          'd5','d6','e5','f6','e4','f4','g4',
          'e3','d3','c3','b2','c5','b6'
        ]
        expect(move_manager.valid_queen_moves(d4)).to eq(valid_moves)
      end
    end
  end

  describe '#valid_moves_in_direction' do
    subject(:move_manager) { described_class.new(Board.new) }
    let(:d5) { move_manager.board.board[3][3] }
    before do
      set_piece('white', Rook, 'd5')
    end

    context 'when given cell d5' do
      it 'returns all valid spaces in the up direction' do
        valid_cells = ['d6','d7','d8']
        expect(move_manager.valid_moves_in_direction(d5, :up)).to eq(valid_cells)
      end
    end

    context 'when given cell d5 and friendly on d8' do
      it 'returns all valid spaces in the up direction' do
        set_piece('white', Pawn, 'd8')
        valid_cells = ['d6','d7']
        expect(move_manager.valid_moves_in_direction(d5, :up)).to eq(valid_cells)
      end
    end

    context 'when given cell d5 and enemy on d7' do
      it 'returns all valid spaces in the up direction' do
        set_piece('black', Pawn, 'd7')
        valid_cells = ['d6','d7']
        expect(move_manager.valid_moves_in_direction(d5, :up)).to eq(valid_cells)
      end
    end
  end
end

#Helper Methods
def set_piece(color, piece_type, coordinate)
  piece = Piece.piece_for(color, piece_type)
  move_manager.board.place_piece(piece, coordinate)
end

def strings_to_cells(strings)
  cells = []
  strings.each { |coordinate| cells << board.space_at(coordinate)}
  cells
end