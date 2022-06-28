
require_relative '../lib/main'

describe Game do

  describe '#player1_turn?' do
    subject(:game) { described_class.new }
    context 'when @turn is 1' do
      it 'returns true' do
        expect(game.player1_turn?).to be true
      end
    end

    context 'when @turn is 2' do
      it 'returns false' do
        game.instance_variable_set(:@turn, 100)
        expect(game.player1_turn?).to be false
      end
    end
  end

  describe '#board_from_fen' do
    let(:fen_board) { "r7/r1pb4/8/8/8/8/1Q1N4/4K3"}
    let(:game) { described_class.new }
    before do
      game.instance_variable_set(:@board, fen_board)
      game.board_from_fen
    end

    context 'when board is loaded from fen' do
      it 'piece at a8 is a rook' do
        a8 = game.board.board[0][0]
        expect(a8.piece).to be_a Rook
      end

      it 'rook color at a8 is black' do
        a8 = game.board.board[0][0]
        piece = a8.piece
        expect(piece.color).to eq('black')
      end

      it 'piece at a7 is a rook' do
        a7 = game.board.board[1][0]
        piece = a7.piece
        expect(piece.color).to eq('black')
      end

      it 'piece at b8 is an EmptySpace' do
        b8 = game.board.board[0][1]
        piece = b8.piece
        expect(piece).to be_a EmptySpace
      end

      it 'piece at d2 is a Knight' do
        d2 = game.board.board[6][3]
        piece = d2.piece
        expect(piece).to be_a Knight
      end

      it 'Knight at d2 is white' do
        d2 = game.board.board[6][3]
        piece = d2.piece
        expect(piece.color).to eq('white')
      end
    end
  end
end


#Helper Methods

def set_piece(color_letter, piece_name, coordinate)
  row = selection_to_array_row(coordinate)
  column = selection_to_array_column(coordinate)
  piece = create_piece(color_letter, piece_name)

  game.board.board[row][column].content = " #{piece} "
end
