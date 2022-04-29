
require 'pry'
require 'board'
require 'coordinate'
# require 'miscellaneous'

describe Board do
  # include Miscellaneous

  describe '#create_board_spaces' do
    subject(:board) { described_class.new }
    context 'when spaces are created for the board' do
      it 'can return the name of the space when asked' do
        board.create_board_spaces
        expect(board.board[6][3].name).to eq('d2')
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
