
require 'board'
require 'miscellaneous'

describe Board do
  include Miscellaneous

  describe '#set_piece' do
    subject(:board) { described_class.new }
    context 'when placing a white pawn at d2' do
      it 'sets a white pawn at d2' do
        board.set_piece('w', 'pawn', 'd2')
        expect(board.board[6][3]).to eq(" #{"\u265F".encode('utf-8')} ")
      end
    end
  end

  describe '#clear_piece' do
    subject(:board) { described_class.new }
    context 'when a space with a piece is selected' do
      it 'clears the piece from that space' do
        set_piece('w', 'pawn', 'd2')
        board.clear_piece('d2')

        expect(board.board[6][3]).to eq('   ')
      end
    end
  end

  describe '#space_empty?' do
    subject(:board) { described_class.new }
    context 'when a space is empty' do
      it 'returns true' do
        expect(board.space_empty?('e7')).to be true
      end
    end

    context 'when a space is not empty' do
      it 'returns false' do
        set_piece('w', 'pawn', 'e7')
        expect(board.space_empty?('e7')).to be false
      end
    end
  end

end


#Helper Methods

def set_piece(color_letter, piece_name, coordinate)
  row = selection_to_array_row(coordinate)
  column = selection_to_array_column(coordinate)
  piece = create_piece(color_letter, piece_name)

  board.board[row][column] = " #{piece} "
end
