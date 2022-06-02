
require_relative '../lib/main'

describe Coordinate do

  describe '#empty?' do
    subject(:coordinate) { described_class.new(6,3) }
    context 'when a space is empty' do
      it 'returns true' do
        expect(coordinate.empty?).to be true
      end
    end
    
    context 'when a space is not empty' do
      it 'returns false' do
        coordinate.content = 'not empty'
        expect(coordinate.empty?).to be false
      end
    end
  end

  describe '#clear_piece' do
    subject(:coordinate) { described_class.new(6,3) }
    context 'when a space with a piece is selected' do
      it 'clears the piece from that space' do
        coordinate.content = 'occupied'
        coordinate.clear_piece

        expect(coordinate.content).to eq('   ')
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

    context 'when given a coordinate input' do
      it 'alters the name of the coordinate given' do
        expect(coordinate.alter_name('e3',0,1)).to eq('e4')
      end
    end
  end

  describe '#all_spaces_in_direction' do
    subject(:coordinate) { described_class.new(3,1)}
    context 'when space name is b5' do
      it 'returns the name of all spaces in the up direction' do
        above = ['b6','b7','b8']
        expect(coordinate.all_spaces_in_direction('b5',0,1)).to eq(above)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the up right direction' do
        up_right = ['c6','d7','e8']
        expect(coordinate.all_spaces_in_direction('b5',1,1)).to eq(up_right)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the right direction' do
        right = ['c5','d5','e5','f5','g5','h5']
        expect(coordinate.all_spaces_in_direction('b5',1,0)).to eq(right)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the down right direction' do
        down_right = ['c4','d3','e2','f1']
        expect(coordinate.all_spaces_in_direction('b5',1,-1)).to eq(down_right)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the down direction' do
        down = ['b4','b3','b2','b1']
        expect(coordinate.all_spaces_in_direction('b5',0,-1)).to eq(down)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the down left direction' do
        down_left = ['a4']
        expect(coordinate.all_spaces_in_direction('b5',-1,-1)).to eq(down_left)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the left direction' do
        left = ['a5']
        expect(coordinate.all_spaces_in_direction('b5',-1,0)).to eq(left)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the up left direction' do
        up_left = ['a6']
        expect(coordinate.all_spaces_in_direction('b5',-1,1)).to eq(up_left)
      end
    end
  end
end


#Helper Methods

def set_piece(color_letter, piece_name, coordinate)
  space = game.space_at(coordinate)
  piece = create_piece(color_letter, piece_name)

  space.content = " #{piece} "
end