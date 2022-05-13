require 'pry'
require 'valid_piece_moves'
require 'game'
require 'miscellaneous'

describe ValidPieceMoves do
  include Miscellaneous
  
  describe '#valid_pawn_moves' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    context 'when a white pawn is at b2' do
      it 'returns an array with valid moves' do
        set_piece('w','pawn','b2')
        expect(game.valid_pawn_moves('b2')).to eq(['b3', 'b4'])
      end
    end

    context 'when a white pawn is at c2, blocked, with enemies' do
      it 'returns an array with valid moves' do
        set_piece('w', 'pawn', 'c2')
        set_piece('b', 'pawn', 'c3')
        set_piece('b', 'pawn', 'b3')
        set_piece('b', 'pawn', 'd3')
        expect(game.valid_pawn_moves('c2')).to eq(['b3', 'd3'])
      end
    end

    context 'when a white pawn is at e2, blocked, with enemies' do
      it 'returns an array with valid moves' do
        set_piece('w', 'pawn', 'c2')
        set_piece('b', 'pawn', 'c4')
        set_piece('b', 'pawn', 'b3')
        expect(game.valid_pawn_moves('c2')).to eq(['c3', 'b3'])
      end
    end
  
    context 'when a black pawn is at f7' do
      it 'returns an array with valid moves' do
        game.instance_variable_set(:@turn, 2)
        set_piece('b', 'pawn', 'f7')
        expect(game.valid_pawn_moves('f7')).to eq(['f6', 'f5'])
      end
    end

    context 'when a black pawn is at f7, blocked, with enemies' do
      it 'returns an array with valid moves' do
        game.instance_variable_set(:@turn, 2)
        set_piece('b', 'pawn', 'f7')
        set_piece('w', 'pawn', 'f5')
        set_piece('w', 'pawn', 'e6')
        set_piece('w', 'pawn', 'g6')
        
        expect(game.valid_pawn_moves('f7')).to eq(['f6', 'e6', 'g6'])
      end
    end
  end

  describe '#valid_moves_in_direction' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    before do
      set_piece('w','rook','d4')
    end

    context 'when rook is on space d4 and the direction is up' do
      it 'returns available valid spaces in the up direction' do
        above = ['d5','d6','d7','d8']
        expect(game.valid_moves_in_direction('d4',0,1)).to eq(above)
      end

      it 'returns available valid spaces in the up direction with enemy above' do
        set_piece('b','pawn','d7')
        above = ['d5','d6','d7']
        expect(game.valid_moves_in_direction('d4',0,1)).to eq(above)
      end

      it 'returns available valid spaces in the up direction with friend above' do
        set_piece('w','pawn','d7')
        above = ['d5','d6']
        expect(game.valid_moves_in_direction('d4',0,1)).to eq(above)
      end
    end

    context 'when rook is on space d4 and the direction is up right' do
      it 'returns available valid spaces in the up right direction' do
        up_right = ['e5','f6','g7','h8']
        expect(game.valid_moves_in_direction('d4',1,1)).to eq(up_right)
      end

      it 'returns available valid spaces in the up right direction' do
        set_piece('b','pawn','f6')
        up_right = ['e5','f6']
        expect(game.valid_moves_in_direction('d4',1,1)).to eq(up_right)
      end

      it 'returns available valid spaces in the up right direction' do
        set_piece('w','pawn','g7')
        up_right = ['e5','f6']
        expect(game.valid_moves_in_direction('d4',1,1)).to eq(up_right)
      end
    end

    context 'when rook is on space d4 and the direction is right' do
      it 'returns available valid spaces in the right direction' do
        right = ['e4','f4','g4','h4']
        expect(game.valid_moves_in_direction('d4',1,0)).to eq(right)
      end

      it 'returns available valid spaces in the right direction' do
        set_piece('b','pawn','f4')
        right = ['e4','f4']
        expect(game.valid_moves_in_direction('d4',1,0)).to eq(right)
      end

      it 'returns available valid spaces in the right direction' do
        set_piece('w','pawn','g4')
        right = ['e4','f4']
        expect(game.valid_moves_in_direction('d4',1,0)).to eq(right)
      end
    end

    context 'when rook is on space d4 and the direction is down right' do
      it 'returns available valid spaces in the down right direction' do
        down_right = ['e3', 'f2', 'g1']
        expect(game.valid_moves_in_direction('d4',1,-1)).to eq(down_right)
      end

      it 'returns available valid spaces in the down right direction' do
        set_piece('b','pawn','f2')
        down_right = ['e3', 'f2']
        expect(game.valid_moves_in_direction('d4',1,-1)).to eq(down_right)
      end

      it 'returns available valid spaces in the down right direction' do
        set_piece('w','pawn','g1')
        down_right = ['e3', 'f2']
        expect(game.valid_moves_in_direction('d4',1,-1)).to eq(down_right)
      end
    end

    context 'when rook is on space d4 and the direction is down' do
      it 'returns available valid spaces in the down direction' do
        down = ['d3','d2','d1']
        expect(game.valid_moves_in_direction('d4',0,-1)).to eq(down)
      end

      it 'returns available valid spaces in the down direction' do
        set_piece('b','pawn','d2')
        down = ['d3','d2']
        expect(game.valid_moves_in_direction('d4',0,-1)).to eq(down)
      end

      it 'returns available valid spaces in the down direction' do
        set_piece('w','pawn','d1')
        down = ['d3','d2']
        expect(game.valid_moves_in_direction('d4',0,-1)).to eq(down)
      end
    end

    context 'when rook is on space d4 and the direction is down left' do
      it 'returns available valid spaces in the down left direction' do
        down_left = ['c3','b2','a1']
        expect(game.valid_moves_in_direction('d4',-1,-1)).to eq(down_left)
      end

      it 'returns available valid spaces in the down left direction' do
        set_piece('b','pawn','b2')
        down_left = ['c3','b2']
        expect(game.valid_moves_in_direction('d4',-1,-1)).to eq(down_left)
      end

      it 'returns available valid spaces in the down left direction' do
        set_piece('w','pawn','a1')
        down_left = ['c3','b2']
        expect(game.valid_moves_in_direction('d4',-1,-1)).to eq(down_left)
      end
    end

    context 'when rook is on space d4 and the direction is left' do
      it 'returns available valid spaces in the left direction' do
        left = ['c4','b4','a4']
        expect(game.valid_moves_in_direction('d4',-1,0)).to eq(left)
      end

      it 'returns available valid spaces in the left direction' do
        set_piece('b','pawn','b4')
        left = ['c4','b4']
        expect(game.valid_moves_in_direction('d4',-1,0)).to eq(left)
      end

      it 'returns available valid spaces in the left direction' do
        set_piece('w','pawn','a4')
        left = ['c4','b4']
        expect(game.valid_moves_in_direction('d4',-1,0)).to eq(left)
      end
    end

    context 'when rook is on space d4 and the direction is up left' do
      it 'returns available valid spaces in the up left direction' do
        up_left = ['c5','b6','a7']
        expect(game.valid_moves_in_direction('d4',-1,1)).to eq(up_left)
      end

      it 'returns available valid spaces in the up left direction' do
        set_piece('b','pawn','b6')
        up_left = ['c5','b6']
        expect(game.valid_moves_in_direction('d4',-1,1)).to eq(up_left)
      end

      it 'returns available valid spaces in the up left direction' do
        set_piece('w','pawn','a7')
        up_left = ['c5','b6']
        expect(game.valid_moves_in_direction('d4',-1,1)).to eq(up_left)
      end
    end
  end

  describe '#valid_knight_moves' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    before do
      set_piece('w','knight','d4')
    end

    context 'when knight is placed on space d4' do
      it 'returns all available spaces' do
        moves = ['c6','e6','f5','f3','e2','c2','b3','b5']
        expect(game.valid_knight_moves('d4')).to eq(moves)
      end

      it 'returns all available spaces blocked with friends and enemies' do
        set_piece('w','pawn','c6')
        set_piece('w','pawn','b3')
        set_piece('b','pawn','e6')
        set_piece('b','pawn','f3')
        moves = ['e6','f5','f3','e2','c2','b5']
        expect(game.valid_knight_moves('d4')).to eq(moves)
      end
    end
  end

  describe '#valid_king_moves' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    before do
      set_piece('w','king','d4')
    end

    context 'when king is placed on space d4' do
      it 'returns all available spaces' do
        moves = ['d5','e5','e4','e3','d3','c3','c4','c5']
        expect(game.valid_king_moves('d4')).to eq(moves)
      end

      it 'returns all available spaces blocked with friends and enemies' do
        set_piece('w','pawn','d5')
        set_piece('w','pawn','c3')
        set_piece('b','pawn','e5')
        set_piece('b','pawn','d3')
        moves = ['e5','e4','e3','d3','c4','c5']
        expect(game.valid_king_moves('d4')).to eq(moves)
      end
    end
  end

  describe '#valid_rook_moves' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    before do
      set_piece('w','rook','d4')
    end

    context 'when rook is placed on space d4' do
      it 'returns valid spaces in all directions' do
        moves = ['d5','d6','d7','d8','e4','f4','g4','h4','d3','d2','d1','c4','b4','a4']
        expect(game.valid_rook_moves('d4')).to eq(moves)
      end

      it 'returns valid spaces in all directions with friends and enemies' do
        set_piece('w','pawn','d7')
        set_piece('b','pawn','g4')
        set_piece('b','pawn','d3')
        set_piece('w','pawn','c4')
        moves = ['d5','d6','e4','f4','g4','d3']
        expect(game.valid_rook_moves('d4')).to eq(moves)
      end
    end
  end

  describe '#valid_queen_moves' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    before do
      set_piece('w','queen','d4')
    end

    context 'when queen is placed on space d4' do
      it 'returns all valid spaces' do
        moves = [
          'd5','d6','d7','d8','e5','f6','g7','h8','e4','f4','g4','h4',
          'e3','f2','g1','d3','d2','d1','c3','b2','a1','c4','b4','a4',
          'c5','b6','a7'
        ]
        expect(game.valid_queen_moves('d4')).to eq(moves)
      end

      it 'returns all valid spaces with friends and enemies blocking' do
        set_piece('w','pawn','d7')
        set_piece('w','pawn','g7')
        set_piece('b','pawn','g4')
        set_piece('b','pawn','e3')
        set_piece('b','pawn','d3')
        set_piece('w','pawn','a1')
        set_piece('w','pawn','c4')
        set_piece('b','pawn','b6')
        moves = [
          'd5','d6','e5','f6','e4','f4','g4',
          'e3','d3','c3','b2','c5','b6'
        ]
        expect(game.valid_queen_moves('d4')).to eq(moves)
      end
    end
  end

  describe '#valid_bishop_moves' do
    subject(:game) { Game.new(Board.new) { extend ValidPieceMoves } }
    before do
      set_piece('w','bishop','d4')
    end

    context 'when bishop is placed on space d4' do
      it 'returns all valid spaces' do
        moves = [
          'e5','f6','g7','h8','e3','f2','g1',
          'c3','b2','a1','c5','b6','a7'
        ]
        expect(game.valid_bishop_moves('d4')).to eq(moves)
      end

      it 'returns all valid spaces with friends and enemies' do
        set_piece('b','pawn','f6')
        set_piece('w','pawn','f2')
        set_piece('b','pawn','a1')
        set_piece('w','pawn','c5')
        moves = ['e5','f6','e3','c3','b2','a1']
        expect(game.valid_bishop_moves('d4')).to eq(moves)
      end
    end
  end
end

#Helper Methods

def set_piece(color_letter, piece_name, coordinate)
  space = game.select_space(coordinate)
  piece = create_piece(color_letter, piece_name)

  space.content = " #{piece} "
end
