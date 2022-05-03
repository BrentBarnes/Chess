
require 'coordinate'
require 'miscellaneous'
require 'pry'

describe Coordinate do

  describe '#set_piece' do
    subject(:coordinate) { described_class.new(6,3) }
    context 'when placing a white pawn at d2' do
      it 'sets a white pawn at d2' do
        coordinate.set_piece('w', 'pawn')
        expect(coordinate.content).to eq(" #{"\u265F".encode('utf-8')} ")
      end
    end
  end

  describe '#space_empty?' do
    subject(:coordinate) { described_class.new(6,3) }
    context 'when a space is empty' do
      it 'returns true' do
        expect(coordinate.space_empty?).to be true
      end
    end

    context 'when a space is not empty' do
      it 'returns false' do
        coordinate.set_piece('w', 'pawn')
        expect(coordinate.space_empty?).to be false
      end
    end
  end

  describe '#clear_piece' do
    subject(:coordinate) { described_class.new(6,3) }
    context 'when a space with a piece is selected' do
      it 'clears the piece from that space' do
        coordinate.set_piece('w', 'pawn')
        coordinate.clear_piece

        expect(coordinate.content).to eq('   ')
      end
    end
  end

  describe '#get_piece_on_space' do
    subject(:coordinate) { described_class.new(6,3) }
    context 'when a white pawn is on the space' do
      it 'returns just the white pawn' do
        coordinate.set_piece('w', 'pawn')
        pawn = "\u265F".encode('utf-8')
        expect(coordinate.get_piece_on_space).to eq(pawn)
      end
    end
  end

  describe '#get_name_of_piece' do
    subject(:coordinate) { described_class.new(6,3) }
    context 'when piece on the board is a white pawn' do
      it 'returns w_pawn' do
        coordinate.set_piece('w', 'pawn')
        coordinate.get_name_of_piece
        expect(coordinate.piece).to eq('w_pawn')
      end
    end

    context 'when piece on the board is a black pawn' do
      it 'returns b_pawn' do
        coordinate.set_piece('b', 'pawn')
        coordinate.get_name_of_piece
        expect(coordinate.piece).to eq('b_pawn')
      end
    end

    context 'when space is empty' do
      it 'returns nil' do
        coordinate.get_name_of_piece
        expect(coordinate.piece).to eq(nil)
      end
    end
  end

  describe '#alter_name' do
    subject(:coordinate) { described_class.new(2,2) }
    context 'when space selected is c6' do
      it 'returns the name of the space above' do
        expect(coordinate.up).to eq('c7')
      end

      it 'returns the name of the space above and right' do
        expect(coordinate.up_right).to eq('d7')
      end

      it 'returns the name of the space to the right' do
        expect(coordinate.right).to eq('d6')
      end

      it 'returns the name of the space below and right' do
        expect(coordinate.down_right).to eq('d5')
      end

      it 'returns the name of the space below' do
        expect(coordinate.down).to eq('c5')
      end

      it 'returns the name of the space below and left' do
        expect(coordinate.down_left).to eq('b5')
      end

      it 'returns the name of the space to the left' do
        expect(coordinate.left).to eq('b6')
      end

      it 'returns the name of the space above and left' do
        expect(coordinate.up_left).to eq('b7')
      end
    end
  end
end