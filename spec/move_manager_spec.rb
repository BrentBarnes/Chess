
require_relative '../lib/main'

describe MoveManager do

  describe '#valid_moves_for' do
    let(:game) { Game.new }
    subject(:move_manager) { described_class.new(game, game.board) }
    let(:d4) { game.board.board[4][3] }
    before do
      set_piece('white', Queen, 'd4')
    end

    context 'when piece on space is a king' do
      it 'runs valid_king_moves' do
        set_piece('white', King, 'd2')
        d2 = cell_at('d2')
        expect(move_manager).to receive(:valid_king_moves).once
        move_manager.valid_moves_for(d2)
      end
    end

    context 'when piece on space is a queen' do
      it 'runs valid_queen_moves' do
        set_piece('white', Queen, 'd2')
        d2 = cell_at('d2')
        expect(move_manager).to receive(:valid_queen_moves).once
        move_manager.valid_moves_for(d2)
      end
    end

    context 'when piece on space is a rook' do
      it 'runs valid_rook_moves' do
        set_piece('white', Rook, 'd2')
        d2 = cell_at('d2')
        expect(move_manager).to receive(:valid_rook_moves).once
        move_manager.valid_moves_for(d2)
      end
    end

    context 'when piece on space is a knight' do
      it 'runs valid_knight_moves' do
        set_piece('white', Knight, 'd2')
        d2 = cell_at('d2')
        expect(move_manager).to receive(:valid_knight_moves).once
        move_manager.valid_moves_for(d2)
      end
    end

    context 'when piece on space is a bishop' do
      it 'runs valid_bishop_moves' do
        set_piece('white', Bishop, 'd2')
        d2 = cell_at('d2')
        expect(move_manager).to receive(:valid_bishop_moves).once
        move_manager.valid_moves_for(d2)
      end
    end

    context 'when piece on space is a pawn' do
      it 'runs valid_pawn_moves' do
        set_piece('white', Pawn, 'd2')
        d2 = cell_at('d2')
        expect(move_manager).to receive(:valid_pawn_moves).once
        move_manager.valid_moves_for(d2)
      end
    end
  end

  describe '#show_valid_moves' do
    let(:game) { Game.new }
    subject(:move_manager) { described_class.new(game, game.board) }
    let(:d4) { game.board.board[4][3] }
    let(:d5) { game.board.board[3][3] }
    before do
      set_piece('white', King, 'd4')
    end

    context 'when King is on d4' do
      it 'returns red circle on empty space d5' do
        move_manager.show_valid_moves(d4)
        expect(d5.piece).to be_a RedCircle
      end
    end

    context 'when King is on d4 and enemy pawn is on d5' do
      it 'makes the background red', focus: true do
        set_piece('black', Pawn, 'd5')
        move_manager.show_valid_moves(d4)
        pawn = d5.piece
        expect(d5.content).to eq(" #{pawn} ".colorize(:red))
      end
    end
  end

  describe '#valid_moves_empty?' do
    let(:game) { Game.new }
    subject(:move_manager) { described_class.new(game, game.board) }
    let(:a1) { game.board.board[7][0] }
    before do
      set_piece('white', Queen, 'a1')
    end

    context 'when the queen has no spaces to move' do
      it 'returns true' do
        set_piece('white', Pawn, 'a2')
        set_piece('white', Pawn, 'b2')
        set_piece('white', Pawn, 'b1')
        expect(move_manager.valid_moves_empty?(a1)).to eq(true)
      end
    end

    context 'when the queen has at least one space to move' do
      it 'returns false' do
        valid_moves = move_manager.valid_moves_for(a1)
        expect(move_manager.valid_moves_empty?(a1)).to eq(false)
      end
    end
  end

  describe '#valid_king_moves' do
    let(:game) { Game.new }
    subject(:move_manager) { described_class.new(game, game.board) }
    let(:d3) { game.board.board[5][3] }
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

        expect(move_manager.valid_king_moves(d3)).to eq(valid_strings)
      end
    end

    context 'when king is in the bottom left corner of the board a1' do
      it 'returns an array of valid moves excluding out of bounds' do
        set_piece('white', King, 'a1')
        a1 = game.board.board[7][0]
        valid_strings = ['a2','b2','b1']

        expect(move_manager.valid_king_moves(a1)).to eq(valid_strings)
      end
    end
  end

  describe '#valid_rook_moves' do
    let(:game) { Game.new }
    subject(:move_manager) { described_class.new(game, game.board) }
    let(:d4) { game.board.board[4][3] }
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
    let(:game) { Game.new }
    subject(:move_manager) { described_class.new(game, game.board) }
    let(:d2) { game.board.board[6][3] }
    before do
      set_piece('white', Knight, 'd2')
    end

    context 'when given a space containing a Knight piece' do
      it 'returns an array of valid moves' do
        valid_moves = ['e4','f3','f1','b1','b3','c4']
        expect(move_manager.valid_knight_moves(d2)).to eq(valid_moves)
      end
    end

    context 'when obstacles block Knight spaces' do
      it 'returns an array of valid moves excluding obstacles' do
        set_piece('white', Pawn,'f3')
        set_piece('white', Pawn,'b3')
        set_piece('black', Pawn,'f1')
        set_piece('black', Pawn,'c4')
        valid_moves = ['e4','f1','b1','c4']

        expect(move_manager.valid_knight_moves(d2)).to eq(valid_moves)
      end
    end
  end

  describe '#valid_bishop_moves' do
    let(:game) { Game.new }
    subject(:move_manager) { described_class.new(game, game.board) }
    let(:d4) { game.board.board[4][3] }
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
    let(:game) { Game.new }
    subject(:move_manager) { described_class.new(game, game.board) }
    let(:d4) { game.board.board[4][3] }
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

  describe '#valid_pawn_moves' do
    let(:game) { Game.new }
    subject(:move_manager) { described_class.new(game, game.board) }
    let(:d2) { game.board.board[6][3] }
    let(:d7) { game.board.board[1][3] }
    before do
      set_piece('white', Pawn, 'd2')
      set_piece('black', Pawn, 'd7')
    end

    context 'when a white pawn is on d2 with no obstructions' do
      it 'returns 2 spaces in front of it' do
        valid_moves = ['d3','d4']
        expect(move_manager.valid_pawn_moves(d2)).to eq(valid_moves)
      end
    end

    context 'when a white pawn is on d2 with two enemies diagonally' do
      it 'returns all 4 possible spaces' do
        set_piece('black', Pawn, 'c3')
        set_piece('black', Pawn, 'e3')
        valid_moves = ['d3','d4','c3','e3']
        expect(move_manager.valid_pawn_moves(d2)).to eq(valid_moves)
      end
    end

    context 'when a white pawn is on d2 with a few obstructions' do
      it 'returns valid moves' do
        set_piece('black', Pawn, 'd4')
        set_piece('black', Pawn, 'c3')
        valid_moves = ['d3','c3']
        expect(move_manager.valid_pawn_moves(d2)).to eq(valid_moves)
      end
    end

    context 'when a white pawn is on h3 with obstructions' do
      let(:h3) { game.board.board[5][7] }
      it 'returns valid moves' do
        set_piece('white', Rook, 'h4')
        valid_moves = []
        expect(move_manager.valid_pawn_moves(h3)).to eq(valid_moves)
      end

      it 'returns valid moves' do
        valid_moves = ['h4']
        expect(move_manager.valid_pawn_moves(h3)).to eq(valid_moves)
      end
    end

    context 'when a black pawn is on d7 without obstructions' do
      it 'returns two spaces below it' do
        move_manager.game.instance_variable_set(:@turn, 2)
        valid_moves = ['d6','d5']
        expect(move_manager.valid_pawn_moves(d7)).to eq(valid_moves)
      end
    end

    context 'when a black pawn is on d7 with two enemies diagonally' do
      it 'returns all 4 possible spaces' do
        game.instance_variable_set(:@turn, 2)
        set_piece('white', Pawn, 'c6')
        set_piece('white', Pawn, 'e6')
        valid_moves = ['d6','d5', 'c6','e6']
        expect(move_manager.valid_pawn_moves(d7)).to eq(valid_moves)
      end
    end

    context 'when a black pawn is on d7 with a few obstructions' do
      it 'returns valid moves' do
        game.instance_variable_set(:@turn, 2)
        set_piece('white', Pawn, 'c6')
        set_piece('black', Pawn, 'd6')
        valid_moves = ['c6']
        expect(move_manager.valid_pawn_moves(d7)).to eq(valid_moves)
      end

      let(:a6) { game.board.board[2][0]}
      it 'returns valid moves' do
        game.instance_variable_set(:@turn, 2)
        set_piece('black', Pawn, 'a6')
        set_piece('white', Pawn, 'b5')
        valid_moves = ['a5','b5']
        expect(move_manager.valid_pawn_moves(a6)).to eq(valid_moves)
      end
    end
  end

  describe '#valid_moves_in_direction' do
    let(:game) { Game.new }
    subject(:move_manager) { described_class.new(game, game.board) }
    let(:d5) { game.board.board[3][3] }
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
  game.board.place_piece(piece, coordinate)
end

def cell_at(coordinate)
  game.cell_at(coordinate)
end

def strings_to_cells(strings)
  cells = []
  strings.each { |coordinate| cells << game.board.cell_at(coordinate)}
  cells
end