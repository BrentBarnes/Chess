
require_relative '../lib/main'

describe Board do

  describe '#create_board' do
    subject(:board) { described_class.new }
    context 'when spaces are created for the board' do
      it 'can return the name of the space when asked' do
        board.create_board
        expect(board.board[6][3].name).to eq('d2')
      end
    end
  end

    describe '#space_at' do
    subject(:board) { described_class.new }
    context 'when selection is valid' do
      it 'returns selected empty cell object' do
        coord_obj = board.board[6][3]
        expect(board.space_at('d2')).to eq(coord_obj)
      end

      it 'returns selected occupied cell object' do
        board.place_piece(Pawn.new('white'), 'd2')
        white_pawn = "\u265F".encode('utf-8')
        space = board.space_at('d2')
        expect(space.content).to eq(" #{white_pawn} ")
      end
    end

    describe '#get' do
      subject(:board) { described_class.new }
      context 'when selection is valid' do
        it ' returns the cell object' do
          cell = board.board[6][3]
          x = 3
          y = 6
          expect(board.get(x, y)).to eq(cell)
        end
      end
    end

    describe '#in_bounds?' do
      subject(:board) { described_class.new }
      context 'when coordinate is in bounds' do
        it 'returns true' do
          expect(board.in_bounds?('f3')).to eq(true)
        end
      end
  
      context 'when coordinate is not bounds' do
        it 'returns false' do
          expect(board.in_bounds?('z9')).to eq(false)
        end
      end
    end

    describe '#place_piece' do
      subject(:board) { described_class.new }
      context 'when placing a white pawn at d2' do
        it 'sets a white pawn at d2' do
          space = board.board[6][3]
          board.place_piece(Pawn.new('white'), 'd2')
          expect(space.content).to eq(" #{"\u265F".encode('utf-8')} ")
        end
      end
    end

    describe '#set_pieces_on_board' do
      subject(:board) { described_class.new }
      before do
        board.set_pieces_on_board
      end

      context 'after placing all of the pieces on the board' do
        it 'sets first black piece (black rook) on a8' do
          space = board.board[0][0]
          black_rook =  "\u2656".encode('utf-8')
          expect(space.content).to eq(" #{black_rook} ")
        end

        it 'sets last black piece (black pawn) on h7' do
          space = board.board[1][7]
          black_pawn = "\u2659".encode('utf-8')
          expect(space.content).to eq(" #{black_pawn} ")
        end

        it 'sets first white piece (white pawn) on a2' do
          space = board.board[6][0]
          white_pawn = "\u265F".encode('utf-8')
          expect(space.content).to eq(" #{white_pawn} ")
        end

        it 'sets last white piece (white rook) on h8' do
          space = board.board[7][7]
          white_rook =  "\u265C".encode('utf-8')
          expect(space.content).to eq(" #{white_rook} ")
        end
      end
    end

    # describe '#space_up' do
    #   subject(:board) { described_class.new }
    #   context 'when given space d2' do
    #     it 'returns the space object for d3' do
    #       space_above = board.board[5][3]
    #       expect(board.space_up('d2')).to eq(space_above)
    #     end

    #     it 'updates space_objects up instance variable' do
    #       space_d2 = board.board[6][3]
    #       space_above = board.board[5][3]
    #       board.space_up('d2')
    #       up = space_d2.instance_variable_get(:@up)
    #       expect(up).to eq(space_above)
    #     end
    #   end
    # end
  end
end
