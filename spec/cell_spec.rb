
require_relative '../lib/main'

describe Cell do

  describe '#empty?' do
    let(:board) { Board.new }
    subject(:cell) { described_class.new(6,3,board) }
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

  describe '#clear_piece' do
    let(:board) { Board.new }
    subject(:cell) { described_class.new(6,3,board) }
    context 'when a space with a piece is selected' do
      it 'clears the piece from that space' do
        cell.content = 'occupied'
        cell.clear_piece

        expect(cell.content).to eq('   ')
      end
    end
  end

    context 'when given a cell input' do
      it 'alters the name of the cell given' do
        expect(cell.alter_name('e3',0,1)).to eq('e4')
      end
    end
  end

  describe '#all_spaces_in_direction' do
    let(:board) { Board.new }
    subject(:cell) { described_class.new(3,1,board)}
    context 'when space name is b5' do
      it 'returns the name of all spaces in the up direction' do
        above = ['b6','b7','b8']
        expect(cell.all_spaces_in_direction('b5',0,1)).to eq(above)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the up right direction' do
        up_right = ['c6','d7','e8']
        expect(cell.all_spaces_in_direction('b5',1,1)).to eq(up_right)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the right direction' do
        right = ['c5','d5','e5','f5','g5','h5']
        expect(cell.all_spaces_in_direction('b5',1,0)).to eq(right)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the down right direction' do
        down_right = ['c4','d3','e2','f1']
        expect(cell.all_spaces_in_direction('b5',1,-1)).to eq(down_right)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the down direction' do
        down = ['b4','b3','b2','b1']
        expect(cell.all_spaces_in_direction('b5',0,-1)).to eq(down)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the down left direction' do
        down_left = ['a4']
        expect(cell.all_spaces_in_direction('b5',-1,-1)).to eq(down_left)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the left direction' do
        left = ['a5']
        expect(cell.all_spaces_in_direction('b5',-1,0)).to eq(left)
      end
    end

    context 'when space name is b5' do
      it 'returns the name of all spaces in the up left direction' do
        up_left = ['a6']
        expect(cell.all_spaces_in_direction('b5',-1,1)).to eq(up_left)
      end
    end

    describe '#up' do
      let(:board) { Board.new }
      subject(:cell) { described_class.new(1,3,board)}
      context 'when the current space is d7' do
        it 'returns the d8 cell object above' do
          up_cell = board.space_at('d8')
          expect(cell.up).to eq(up_cell)
        end
      end

      context 'when a pawn is on the space above' do
        it 'returns the piece in the cell object above' do
          board.place_piece(Pawn.new('white'), 'd8')
          up_cell = board.space_at('d8')
          expect(cell.up.piece.to_s).to eq('♟')
        end
      end
    end
  end
end


#Helper Methods

def set_piece(color_letter, piece_name, cell)
  space = game.space_at(cell)
  piece = create_piece(color_letter, piece_name)

  space.content = " #{piece} "
end