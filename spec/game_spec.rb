
require 'pry'
require 'game'
require 'miscellaneous'

describe Game do
  include Miscellaneous

  describe '#move_piece' do
    subject(:game) { described_class.new(Board.new) }
    let(:pawn) { "\u265F".encode('utf-8') }
    before do
      set_piece('w', 'pawn', 'd2')
    end

    context 'when input is d2, d3' do
      it 'moves pawn one space forward' do
        game.move_piece('d2', 'd3')
        expect(game.select_space('d3')).to eq(" #{pawn} ")
      end
    end

    context 'when pawn tries to move ontop of friendly piece' do
      it 'calls the function again' do
        set_piece('w', 'pawn', 'd3')
        allow(game).to receive(:gets).and_return('d2', 'd5')
        expect(game).to receive(:move_piece).and_call_original.twice
        game.move_piece('d2', 'd3')
      end
    end

    context 'when input is white piece moves ontop of black piece' do
      it 'white pawn takes black pawn' do
        set_piece('b', 'pawn', 'd3')
        game.move_piece('d2', 'd3')
        expect(game.select_space('d3')).to eq(" #{pawn} ")
      end
    end

    context 'when input is white piece moves ontop of black piece' do
      it 'sends black piece to graveyard' do
        set_piece('b', 'pawn', 'd3')
        game.move_piece('d2', 'd3')
        p2_graveyard = game.board.instance_variable_get(:@p2_graveyard)
        b_pawn = "\u2659".encode('utf-8')
        expect(p2_graveyard[0]).to eq("#{b_pawn}")
      end
    end
  end
  
  describe '#select_space' do
    subject(:game) { described_class.new(Board.new) }
    context 'when given chess coordinate a1' do
      it 'converts selection and returns space from array' do
        expect(game.select_space('a1')).to eq(game.board.board[7][0])
      end
    end

    context 'when given chess coordinate h8' do
      it 'converts selection and returns space from array' do
        expect(game.select_space('h8')).to eq(game.board.board[0][7])
      end
    end

    context 'when not passed selection as an argument' do
      it 'gets selection from user' do
        allow(game).to receive(:gets).and_return('g3')
        expect(game).to receive(:gets).once
        game.select_space
      end
    end

    context 'when not passed selection as an argument' do
      it 'gets selection from user and output is correct' do
        allow(game).to receive(:gets).and_return('g3')
        expect(game.select_space).to eq(game.board.board[5][6])
      end
    end
  end

  describe '#valid_space?' do
    subject(:game) { described_class.new(Board.new) }
    context 'when given valid input c5' do
      it 'returns true' do
        expect(game.valid_space?('c5')).to be true
      end
    end

    context 'when given invalid input cc' do
      it 'returns false' do
        expect(game.valid_space?('cc')).to be false
      end
    end

    context 'when given invalid input 24' do
      it 'returns false' do
        expect(game.valid_space?('24')).to be false
      end
    end
  end

  describe '#player1_turn?' do
    subject(:game) { described_class.new(Board.new) }
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

  describe '#send_piece_to_graveyard' do
    subject(:game) { described_class.new(Board.new) }
    context 'when the coordinate of a white piece is passed in' do
      it 'sends that piece to player 1s graveyard' do
        set_piece('w', 'pawn', 'c4')
        game.send_piece_to_graveyard('c4')
        p1_graveyard = game.board.instance_variable_get(:@p1_graveyard)
        w_pawn = "\u265F".encode('utf-8')
        expect(p1_graveyard[0]).to eq(w_pawn)
      end
    end

    context 'when the coordinate of a black piece is passed in' do
      it 'sends that piece to player 2s graveyard' do
        set_piece('b', 'pawn', 'c4')
        game.send_piece_to_graveyard('c4')
        p2_graveyard = game.board.instance_variable_get(:@p2_graveyard)
        b_pawn = "\u2659".encode('utf-8')
        expect(p2_graveyard[0]).to eq(b_pawn)
      end
    end
  end

  describe '#same_team?' do
    subject(:game) { described_class.new(Board.new) }
    context 'when it is player 1s turn and the piece is white' do
      it 'returns true' do
        set_piece('w', 'pawn', 'a1')
        
        expect(game.same_team?('a1')).to be true
      end
    end

    context 'when it is player 1s turn and the piece is black' do
      it 'returns false' do
        set_piece('b', 'pawn', 'a1')
        expect(game.same_team?('a1')).to be false
      end
    end

    context 'when it is player 2s turn and the piece is black' do
      it 'returns true' do
        set_piece('b', 'pawn', 'a1')
        game.instance_variable_set(:@turn, 2)
        expect(game.same_team?('a1')).to be true
      end
    end
    
    context 'when it is player 2s turn and the piece is white' do
      it 'returns false' do
        set_piece('w', 'pawn', 'a1')
        game.instance_variable_set(:@turn, 2)
        expect(game.same_team?('a1')).to be false
      end
    end
  end

  describe '#selection_to_array_row' do
    subject(:game) { described_class.new(Board.new) }
    context 'when given chess coordinate a1' do
      it 'converts coordinate to row(1) to array value 7' do
        expect(game.selection_to_array_row('a1')).to eq(7)
      end
    end

    context 'when given chess coordinate h8' do
      it 'converts coordinate row(8) to array value 0' do
        expect(game.selection_to_array_row('h8')).to eq(0)
      end
    end
  end

  describe '#selection_to_array_column' do
    subject(:game) { described_class.new(Board.new) }
    context 'when given chess coordinate a1' do
      it 'converts column(a) to array value 0' do
        expect(game.selection_to_array_column('a1')).to eq(0)
      end
    end

    context 'when given chess coordinate h8' do
      it 'converts column(h) to array value 7' do
        expect(game.selection_to_array_column('h8')).to eq(7)
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

