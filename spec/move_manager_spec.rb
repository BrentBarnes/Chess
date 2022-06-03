
require_relative '../lib/main'

describe MoveManager do

  describe '#valid_king_moves' do
    subject(:move_manager) { described_class.new(Board.new) }
    let(:board) { Board.new }
    before do
      w_king = Piece.piece_for('white', King)
      board.place_piece(w_king, 'd3')
    end

    context 'when given a space containing a King piece' do
      it 'returns an array of valid moves' do
        valid_moves = ['d4','e4','e3','e2','d2','c2','c3','c4']
        w_king = board.board[5][3]
        expect(move_manager.valid_king_moves(w_king)).to eq(valid_moves)
      end
    end

    context 'when a friendly pawn is above the king' do
      it 'returns an array of valid moves excluding friendly space' do
        valid_moves = ['e4','e3','e2','d2','c2','c3','c4']
        w_pawn = Piece.piece_for('white', Pawn)
        board.place_piece(w_pawn, 'd4')
        w_king = board.board[5][3]
        expect(move_manager.valid_king_moves(w_king)).to eq(valid_moves)
      end
    end
  end

end