
require_relative '../lib/main'

describe Board do

  describe '#create_board' do
    let(:game) { Game.new }
      subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }
    context 'when spaces are created for the board' do
      it 'can return the name of the space when asked' do
        board.create_board
        expect(board.board[6][3].name).to eq('d2')
      end
    end
  end

  describe '#cell_at' do
    let(:game) { Game.new }
    subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }

    context 'when selection is valid' do
      it 'returns selected empty cell object' do
        coord_obj = board.board[6][3]
        expect(board.cell_at('d2')).to eq(coord_obj)
      end

      it 'returns selected occupied cell object' do
        board.place_piece(Pawn.new('white'), 'd2')
        white_pawn = "\u265F".encode('utf-8')
        space = board.cell_at('d2')
        expect(space.content).to eq(space.color_content(" #{white_pawn} "))
      end
    end
  end

  describe '#get' do
    let(:game) { Game.new }
    subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }
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
    let(:game) { Game.new }
    subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }
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
    let(:game) { Game.new }
    subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }

    context 'when placing a white pawn at d2' do
      it 'sets a white pawn at d2' do
        space = board.board[6][3]
        board.place_piece(Pawn.new('white'), 'd2')
        expect(space.content).to eq(space.color_content(' ♟ '))
      end
    end
  end

  describe '#set_pieces_on_board' do
    let(:game) { Game.new }
    subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }
    before do
      board.set_pieces_on_board
    end

    context 'after placing all of the pieces on the board' do
      it 'sets first black piece (black rook) on a8' do
        space = board.board[0][0]
        expect(space.content).to eq(space.color_content(' ♖ '))
      end

      it 'sets last black piece (black pawn) on h7' do
        space = board.board[1][7]
        expect(space.content).to eq(space.color_content(' ♙ '))
      end

      it 'sets first white piece (white pawn) on a2' do
        space = board.board[6][0]
        expect(space.content).to eq(space.color_content(' ♟ '))
      end

      it 'sets last white piece (white rook) on h8' do
        space = board.board[7][7]
        white_rook =  "\u265C".encode('utf-8')
        expect(space.content).to eq(space.color_content(' ♜ '))
      end
    end
  end

  describe '#find_king' do
    let(:game) { Game.new }
    subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }
    before do
      board.place_piece(King.new('black'), 'b3')
      board.place_piece(King.new('white'), 'g7')
    end
    
    context 'when white turn and friendly king is on g7' do
      it 'returns the space that the enemy king is on' do
        g7 = board.board[1][6]
        expect(board.find_king('friendly')).to eq(g7)
      end
    end
    
    context 'when black turn and friendly king is on b3' do
      it 'returns the space that the enemy king is on' do
        game.instance_variable_set(:@turn, 2)
        b3 = board.board[5][1]
        expect(board.find_king('friendly')).to eq(b3)
      end
    end

    context 'when white turn and enemy king is on b3' do
      it 'returns the space that the enemy king is on' do
        b3 = board.board[5][1]
        expect(board.find_king('enemy')).to eq(b3)
      end
    end

    context 'when black turn and enemy king is on g7' do
      it 'returns the space that the enemy king is on' do
        game.instance_variable_set(:@turn, 2)
        g7 = board.board[1][6]
        expect(board.find_king('enemy')).to eq(g7)
      end
    end
  end

  describe '#active_king_on_cell?' do
    let(:game) { Game.new }
    subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }
    before do
      board.place_piece(King.new('black'), 'c7')
      board.place_piece(King.new('white'), 'e1')
    end

    context 'when white king is on e1' do
      it 'returns true' do
        e1 = board.board[7][4]
        expect(board.active_king_on_cell?(e1)).to be true
      end
    end

    context 'when white king is on e1 and empty space is selected' do
      it 'returns false' do
        empty_space = board.board[5][4]
        expect(board.active_king_on_cell?(empty_space)).to be false
      end
    end

    context 'when enemy king is selected' do
      it 'returns false' do
        c7 = board.board[1][2]
        expect(board.active_king_on_cell?(c7)).to be false
      end
    end
  end

  describe '#find_pieces' do
    let(:game) { Game.new }
    subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }
    before do
      board.place_piece(Pawn.new('black'), 'c7')
      board.place_piece(Bishop.new('black'), 'd7')
      board.place_piece(Rook.new('black'), 'a7')
      board.place_piece(Pawn.new('white'), 'd2')
      board.place_piece(Bishop.new('white'), 'b2')
      board.place_piece(King.new('white'), 'e1')
    end

    context 'when white turn and there are friendly pieces on d2, b2, and e1' do
      it 'returns their cell objects' do
        d2 = board.board[6][3]
        b2 = board.board[6][1]
        e1 = board.board[7][4]
        cell_array = [d2, b2, e1].sort_by(&:name)
        result = board.find_pieces('friendly')
        expect(cell_array == result).to be true
      end
    end

    context 'when black turn and there are friendly pieces on c7, d7, and a7' do
      it 'returns their cell objects' do
        game.instance_variable_set(:@turn, 2)
        c7 = board.board[1][2]
        d7 = board.board[1][3]
        a7 = board.board[1][0]
        cell_array = [c7, d7, a7].sort_by(&:name)
        result = board.find_pieces('friendly')
        expect(cell_array == result).to be true
      end
    end

    context 'when white turn and there are enemy pieces on c7, d7, and a7' do
      it 'returns their cell objects' do
        c7 = board.board[1][2]
        d7 = board.board[1][3]
        a7 = board.board[1][0]
        cell_array = [c7, d7, a7].sort_by(&:name)
        result = board.find_pieces('enemy')
        expect(cell_array == result).to be true
      end
    end
    
    context 'when black turn and there are enemy pieces on d2, b2, and e1' do
      it 'returns their cell objects' do
        game.instance_variable_set(:@turn, 2)
        d2 = board.board[6][3]
        b2 = board.board[6][1]
        e1 = board.board[7][4]
        cell_array = [d2, b2, e1].sort_by(&:name)
        result = board.find_pieces('enemy')
        expect(cell_array == result).to be true
      end
    end
  end

  describe '#board_to_fen' do
    let(:game) { Game.new }
    subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }
    before do
      board.place_piece(Pawn.new('black'), 'c7')
      board.place_piece(Bishop.new('black'), 'd7')
      board.place_piece(Rook.new('black'), 'a7')
      board.place_piece(Knight.new('white'), 'd2')
      board.place_piece(Queen.new('white'), 'b2')
      board.place_piece(King.new('white'), 'e1')
    end

    context 'when board has 6 pieces on it' do
      it 'returns a representation of the board in fen notation' do
        fen_board = ['e', 'e', 'e', 'e', 'e', 'e', 'e', 'e',
                    'r', 'e', 'p', 'b', 'e', 'e', 'e', 'e',
                    'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e',
                    'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e',
                    'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e',
                    'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e',
                    'e', 'Q', 'e', 'N', 'e', 'e', 'e', 'e',
                    'e', 'e', 'e', 'e', 'K', 'e', 'e', 'e']
        
        expect(board.board_to_fen).to eq(fen_board)
      end
    end
  end

  describe '#board_from_fen' do
    let(:game) { Game.new }
    subject(:board) { described_class.new(game, game.graveyard, game.move_manager) }
    let(:fen_board) { ['r', 'e', 'e', 'e', 'e', 'e', 'e', 'e',
                      'r', 'e', 'p', 'b', 'e', 'e', 'e', 'e',
                      'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e',
                      'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e',
                      'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e',
                      'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e',
                      'e', 'Q', 'e', 'N', 'e', 'e', 'e', 'e',
                      'e', 'e', 'e', 'e', 'K', 'e', 'e', 'e'] }

    before do
      board.board_from_fen(fen_board)
    end

    context 'when board is loaded from fen' do
      it 'piece at a8 is a rook' do
        a8 = board.board[0][0]
        expect(a8.piece).to be_a Rook
      end

      it 'rook color at a8 is black' do
        a8 = board.board[0][0]
        piece = a8.piece
        expect(piece.color).to eq('black')
      end

      it 'piece at a7 is a rook' do
        a7 = board.board[1][0]
        piece = a7.piece
        expect(piece.color).to eq('black')
      end

      it 'piece at b8 is an EmptySpace' do
        b8 = board.board[0][1]
        piece = b8.piece
        expect(piece).to be_a EmptySpace
      end

      it 'piece at d2 is a Knight' do
        d2 = board.board[6][3]
        piece = d2.piece
        expect(piece).to be_a Knight
      end

      it 'Knight at d2 is white' do
        d2 = board.board[6][3]
        piece = d2.piece
        expect(piece.color).to eq('white')
      end
    end
  end
end
