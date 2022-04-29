require 'pry'
require 'valid_piece_moves'
require 'game'
require 'miscellaneous'

describe ValidPieceMoves do
  include Miscellaneous
  
  describe '#w_pawn_valid_moves' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    context 'when a white pawn is at a2' do
      it 'returns an array with valid moves' do
        set_piece('w', 'pawn', 'a2')
        expect(game.w_pawn_valid_moves('a2')).to eq(['a3', 'a4'])
      end
    end

    context 'when a white pawn is at c2, blocked, with enemies' do
      it 'returns an array with valid moves' do
        set_piece('w', 'pawn', 'c2')
        set_piece('b', 'pawn', 'c3')
        set_piece('b', 'pawn', 'b3')
        set_piece('b', 'pawn', 'd3')
        expect(game.w_pawn_valid_moves('c2')).to eq(['b3', 'd3'])
      end
    end

    context 'when a white pawn is at e2, blocked, with enemies' do
      it 'returns an array with valid moves' do
        set_piece('w', 'pawn', 'c2')
        set_piece('b', 'pawn', 'c4')
        set_piece('b', 'pawn', 'b3')
        expect(game.w_pawn_valid_moves('c2')).to eq(['c3', 'b3'])
      end
    end
  end

  describe '#b_pawn_valid_moves' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    context 'when a black pawn is at f7' do
      it 'returns an array with valid moves' do
        set_piece('b', 'pawn', 'f7')
        expect(game.b_pawn_valid_moves('f7')).to eq(['f6', 'f5'])
      end
    end

    context 'when a black pawn is at f7, blocked, with enemies' do
      it 'returns an array with valid moves' do
        game.instance_variable_set(:@turn, 2)
        set_piece('b', 'pawn', 'f7')
        set_piece('w', 'pawn', 'f5')
        set_piece('w', 'pawn', 'e6')
        set_piece('w', 'pawn', 'g6')
        
        expect(game.b_pawn_valid_moves('f7')).to eq(['f6', 'e6', 'g6'])
      end
    end
  end

  describe '#rook_valid_moves' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    context 'when coordinate of rook is e5' do
      xit 'returns an array of valid moves' do
        set_piece('w', 'rook', 'e5')
        up_down = 'e6','e7','e8','e4','e3','e2','e1'
        left_right = 'd5','c5','b5','a5','f5','g5','h5'
        expect(game.rook_valid_moves('e5')).to eq([up_down, left_right].flatten)
      end
    end

    context 'when coordinate of rook is, blocked, with enemies' do
      xit 'returns an array of valid moves' do
        set_piece('w', 'rook', 'e5')
        set_piece('w', 'pawn', 'g5')
        set_piece('w', 'pawn', 'e4')
        set_piece('b', 'pawn', 'e8')
        set_piece('b', 'pawn', 'c5')
        up_down = 'e6','e7','e8'
        left_right = 'd5','c5','f5'
        
        expect(game.rook_valid_moves('e5')).to eq([up_down, left_right].flatten)
      end
    end
  end

  describe '#move_up' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    context 'when coordinate of rook is e5' do
      it 'returns an array of valid moves' do
        set_piece('w', 'rook', 'e5')
        up = 'e6','e7','e8'
        expect(game.move_up('e5')).to eq(up)
      end
    end

    context 'when coordinate of rook is e5' do
      it 'cannot move onto friendly space' do
        set_piece('w', 'rook', 'e5')
        set_piece('w', 'pawn', 'e8')
        up = 'e6','e7'
        expect(game.move_up('e5')).to eq(up)
      end
    end

    context 'when coordinate of rook is e5' do
      it 'can move onto enemy space' do
        set_piece('w', 'rook', 'e5')
        set_piece('b', 'pawn', 'e7')
        up = 'e6','e7'
        expect(game.move_up('e5')).to eq(up)
      end
    end
  end


  describe '#array_to_chess_coord' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    context 'when given (6,0)' do
      it 'returns a2' do
        expect(game.array_to_chess_coord(6,0)).to eq('a2')
      end
    end
  end
end

#Helper Methods

def set_piece(color_letter, piece_name, coordinate)
  row = selection_to_array_row(coordinate)
  column = selection_to_array_column(coordinate)
  piece = create_piece(color_letter, piece_name)

  game.board.board[row][column] = " #{piece} "
end
